import 'package:flutter/material.dart';
import 'package:test_app/colors_data.dart';
import 'package:test_app/models/color_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataClass dataClass = DataClass();
  final List<ColorDataModel> colorDataList = [];
  final Map<String, ColorDataModel?> selectedColorMap = {
    'first_digit': null,
    'second_digit': null,
    'multiplier': null,
    'tolerance': null,
  };

  @override
  void initState() {
    for (var colorData in dataClass.colorDataMap) {
      colorDataList.add(ColorDataModel.fromJson(colorData));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Task(Flutter)'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
            child: const Center(
              child: Text(
                'Click on the White strips to select the color.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          // Register wiget
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                stripeContainer(stripeType: 'first_digit'),
                stripeContainer(stripeType: 'second_digit'),
                stripeContainer(stripeType: 'multiplier'),
                const SizedBox(
                  width: 10,
                ),
                stripeContainer(stripeType: 'tolerance'),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey[300]!)),
          ),
          // Register color combination value
          SizedBox(
            height: 50,
            child: Row(
              children: [
                const SizedBox(
                  width: 22,
                ),
                const Text(
                  'Resistor value:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  getResiterValue,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showSelectColorBottomSheet(
      String stripeType, ColorDataModel? selectedColor) {
    ColorDataModel? colorData = selectedColor;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, changeState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        'select ${stripeType.replaceAll('_', ' ')} color'
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.41,
                    child: ListView.builder(
                        itemCount: colorDataList.length,
                        itemBuilder: (context, index) {
                          return isDataEmpty(stripeType, colorDataList[index])
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    colorData = colorDataList[index];
                                    changeState(() {});
                                  },
                                  child: colorTile(
                                      Color(int.parse(
                                              colorDataList[index]
                                                  .colorData
                                                  .substring(1, 7),
                                              radix: 16) +
                                          0xFF000000),
                                      colorDataList[index].colorName,
                                      colorData != null &&
                                              (colorData!.colorName ==
                                                  colorDataList[index]
                                                      .colorName)
                                          ? true
                                          : false),
                                );
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      color: Colors.blue,
                      onPressed: () {
                        selectedColorMap[stripeType] = colorData;
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget stripeContainer({required String stripeType}) {
    return InkWell(
      onTap: () {
        showSelectColorBottomSheet(stripeType, selectedColorMap[stripeType]);
      },
      child: Container(
        height: double.infinity,
        width: 25,
        color: selectedColorMap[stripeType] != null
            ? Color(int.parse(
                    selectedColorMap[stripeType]!.colorData.substring(1, 7),
                    radix: 16) +
                0xFF000000)
            : Colors.white,
      ),
    );
  }

  Widget colorTile(Color color, String colorName, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: color,
                border: Border.all(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              colorName,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey[300]!, width: 1.2)),
    );
  }

  String get getResiterValue {
    if (selectedColorMap.values.toList().any((element) => element == null)) {
      return '';
    } else {
      double computedValue = int.parse(
              '${selectedColorMap['first_digit']!.digit1}${selectedColorMap['second_digit']!.digit2}') *
          selectedColorMap['multiplier']!.multiplier!;

      return '$computedValueΩ ${selectedColorMap['tolerance']!.tolerance} ';
    }
  }

  bool isDataEmpty(String stripeName, ColorDataModel colorData) {
    if (stripeName == 'first_digit') {
      return colorData.digit1 == null ? true : false;
    } else if (stripeName == 'second_digit') {
      return colorData.digit2 == null ? true : false;
    } else if (stripeName == 'multiplier') {
      return colorData.multiplier == null ? true : false;
    } else {
      return colorData.tolerance == null ? true : false;
    }
  }
}

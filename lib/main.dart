import 'package:flutter/material.dart';
import 'package:test_app/cricket_team.dart';
import 'package:test_app/models/cricket_data_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home1Screen());
  }
}

class Home1Screen extends StatefulWidget {
  const Home1Screen({Key? key}) : super(key: key);

  @override
  State<Home1Screen> createState() => _Home1ScreenState();
}

class _Home1ScreenState extends State<Home1Screen> {
  final DataClass data = DataClass();
  List<CricketDataModel> filterCricketDataList = [];
  List<String> filterList = ['Batsmen', 'Bowlers', 'All-rounders', 'Teams'];
  String tabFilter = 'odi';
  String subFilter = 'Batsmen';

  @override
  void initState() {
    getFilterList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: TabBar(
            onTap: (index) {
              tabFilter = index == 1
                  ? 'test'
                  : index == 2
                      ? 't20'
                      : 'odi';
              getFilterList();
              setState(() {});
            },
            tabs: const [
              Tab(
                child: Text('ODI'),
              ),
              Tab(
                child: Text('TEST'),
              ),
              Tab(
                child: Text('T20'),
              ),
            ],
          ),
          title: const Text('RANKING'),
        ),
        body: TabBarView(
          children: [
            tabBarviewWidget(filterCricketDataList),
            tabBarviewWidget(filterCricketDataList),
            tabBarviewWidget(filterCricketDataList)
          ],
        ),
      ),
    );
  }

  Widget tabBarviewWidget(List<CricketDataModel> data) {
    return Column(
      children: [
        Row(
          children: [
            for (String filter in filterList)
              InkWell(
                onTap: () {
                  subFilter = filter;
                  getFilterList();
                  setState(() {});
                },
                child: Container(
                  color: filter == subFilter ? Colors.blue : null,
                  padding: EdgeInsets.symmetric(
                      vertical: filter == subFilter ? 8 : 0,
                      horizontal: filter == subFilter ? 15 : 0),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    filter,
                    style: TextStyle(
                        color: filter == subFilter ? Colors.white : null),
                  ),
                ),
              )
          ],
        ),
        dataTileWidget(
          playerName: 'Players',
          teamName: 'Teams',
          points: 'Points',
          position: 'Rank',
          rating: 'Rating',
          showColor: true,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return dataTileWidget(
                    playerName: data[index].playerName,
                    teamName: data[index].teamName,
                    points: data[index].points,
                    position: data[index].position,
                    rating: data[index].rating,
                    showColor: index % 2 != 0 ? true : false);
              }),
        )
      ],
    );
  }

  Widget dataTileWidget({
    dynamic position,
    String? teamName,
    String? playerName,
    dynamic rating,
    dynamic points,
    required bool showColor,
  }) {
    return Container(
      color: showColor ? Colors.grey[300] : null,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text('$position'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Text(
                  '${subFilter == 'Teams' ? teamName!.replaceAll(' ', '') : playerName}'),
            ),
          ),
          if (subFilter == 'Teams')
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 70),
              child: Text('$rating'),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text('$points'),
          )
        ],
      ),
    );
  }

  void getFilterList() {
    String filterKey = '$tabFilter$getSubFilterName';
    filterCricketDataList = [];
    data.getresults[filterKey].forEach((rankData) {
      filterCricketDataList.add(CricketDataModel.fromJson(rankData));
    });
  }

  String get getSubFilterName {
    if (subFilter == 'Batsmen') {
      return 'Batsman';
    } else if (subFilter == 'Bowlers') {
      return 'Bowler';
    } else if (subFilter == 'All-rounders') {
      return 'AllRounder';
    } else {
      return 'Teams';
    }
  }
}

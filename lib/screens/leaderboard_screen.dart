import 'package:flutter/material.dart';
import 'package:rpgl/bases/api/leaderboard.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:async';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String selectedGroup = "";
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  Map<String, LeaderboardDataSource> _dataSources = {};
  bool _isLoading = true;
  final bool _isSponsorVisible = true;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _fetchLeaderboardData();
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        double currentScrollPosition = _scrollController.position.pixels;
        double nextScrollPosition = currentScrollPosition + 100;

        if (nextScrollPosition >= maxScrollExtent) {
          nextScrollPosition = 0;
        }

        _scrollController.animateTo(
          nextScrollPosition,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _fetchLeaderboardData() async {
    try {
      LeaderBoard leaderboard = await LeaderBoard.leaderboardlist();

      if (leaderboard.leaderboardDetails != null) {
        final leaderboardDetails = leaderboard.leaderboardDetails!;

        setState(() {
          _dataSources = {}; // Clear previous data sources

          leaderboardDetails.groups.forEach((groupName, groupData) {
            _dataSources[groupName] = LeaderboardDataSource(
                LeaderboardDetails(groups: {groupName: groupData}));
          });

          if (_dataSources.isNotEmpty) {
            selectedGroup =
                _dataSources.keys.first; // Set initial selected group
          }

          _isLoading = false;
        });
      } else {
        print("Leaderboard details are null");
      }
    } catch (e) {
      print("Failed to load leaderboard data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnCount = 8; // Number of columns
    final columnWidth = screenWidth / (columnCount * 1.2);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Leaderboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _dataSources.keys.map((groupName) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedGroup = groupName;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedGroup == groupName
                                ? Colors.blueAccent
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          child: Text(
                            groupName,
                            style: TextStyle(
                              color: selectedGroup == groupName
                                  ? Colors.white
                                  : Colors.blueAccent,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: SfDataGrid(
                    source: _dataSources[selectedGroup] ??
                        LeaderboardDataSource(LeaderboardDetails(
                            groups: {})), // Fallback to an empty data source
                    // SfDataGrid columns definition
                    columns: [
                      GridColumn(
                        columnName: 'team',
                        label: Container(
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.centerLeft,
                          color: Colors.black,
                          child: const Row(
                            children: [
                              SizedBox(width: 4),
                              Text('Team',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        width: 2.70 * columnWidth,
                      ),
                      GridColumn(
                        columnName: 'gp',
                        label: Container(
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          color: Colors.black,
                          child: const Text('GP',
                              style: TextStyle(color: Colors.white)),
                        ),
                        width: columnWidth,
                      ),
                      GridColumn(
                        columnName: 'gw',
                        label: Container(
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          color: Colors.black,
                          child: const Text('GW',
                              style: TextStyle(color: Colors.white)),
                        ),
                        width: columnWidth,
                      ),
                      GridColumn(
                        columnName: 'mo',
                        label: Container(
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          color: Colors.black,
                          child: const Text('MO',
                              style: TextStyle(color: Colors.white)),
                        ),
                        width: columnWidth,
                      ),
                      GridColumn(
                        columnName: 'mw',
                        label: Container(
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          color: Colors.black,
                          child: const Text('MW',
                              style: TextStyle(color: Colors.white)),
                        ),
                        width: columnWidth,
                      ),
                      GridColumn(
                        columnName: 'ml',
                        label: Container(
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          color: Colors.black,
                          child: const Text('ML',
                              style: TextStyle(color: Colors.white)),
                        ),
                        width: columnWidth,
                      ),
                      GridColumn(
                        columnName: 'mt',
                        label: Container(
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          color: Colors.black,
                          child: const Text('MT',
                              style: TextStyle(color: Colors.white)),
                        ),
                        width: columnWidth,
                      ),
                      GridColumn(
                        columnName: 'tp',
                        label: Container(
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          color: Colors.black,
                          child: const Text('TP',
                              style: TextStyle(color: Colors.white)),
                        ),
                        width: columnWidth,
                      ),
                    ],

                    controller: DataGridController(),
                    verticalScrollController: _scrollController,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    // opacity: 1.0,
                    opacity: _isSponsorVisible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.white,
                      child: Image.asset(
                        'assets/images/grantthonton.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class LeaderboardDataSource extends DataGridSource {
  LeaderboardDataSource(this._leaderboardDetails) {
    _buildDataGridRows();
  }

  final LeaderboardDetails _leaderboardDetails;
  List<DataGridRow> _dataGridRows = [];

  void _buildDataGridRows() {
    _leaderboardDetails.groups.forEach((groupName, groupData) {
      _dataGridRows.addAll(groupData.map<DataGridRow>((data) {
        return DataGridRow(cells: [
          DataGridCell<String>(
              columnName: 'team', value: "${data.team},${data.teamImage}"),
          DataGridCell<String>(columnName: 'gp', value: data.played.toString()),
          DataGridCell<String>(columnName: 'gw', value: data.won.toString()),
          DataGridCell<String>(columnName: 'mo', value: data.group.toString()),
          DataGridCell<String>(columnName: 'mw', value: data.won.toString()),
          DataGridCell<String>(columnName: 'ml', value: data.lost.toString()),
          DataGridCell<String>(columnName: 'mt', value: data.lost.toString()),
          DataGridCell<String>(columnName: 'tp', value: data.points.toString()),
        ]);
      }).toList());
    });
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((cell) {
      if (cell.columnName == 'team') {
        String teamName = cell.value.toString().split(',').first;
        String teamImage = cell.value.toString().split(',').last;

        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(teamImage),
                radius: 12,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                teamName,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        );
      } else {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child: Text(cell.value.toString()),
        );
      }
    }).toList());
  }
}

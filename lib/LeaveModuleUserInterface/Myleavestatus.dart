import 'package:buroleave/LeaveModuleUserInterface/createDrawer.dart';
import 'package:buroleave/repository/network/buro_repository.dart';
import 'package:buroleave/sessionmanager/session_manager.dart';
import 'package:flutter/material.dart';

class Myleavestatus extends StatefulWidget {
  static const String routeName = '/leavestatus';
  static route() => MaterialPageRoute(
      builder: (_) => Myleavestatus(
          status: "status",
          adate: "adate",
          startdate: "startdate",
          enddate: "enddate",
          reason: "reason"));
  static const String screen_title = 'History';
  final String status;
  final String adate;
  final String startdate;
  final String enddate;
  final String reason;

  const Myleavestatus(
      {Key? key,
      required this.status,
      required this.adate,
      required this.startdate,
      required this.enddate,
      required this.reason})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyleavecurrentStatus();
  }
}

class MyleavecurrentStatus extends State<Myleavestatus> {
  List<String> litems = ["1", "2", "Third", "4"];
  var repository = BuroRepository();
    late SessionManager sessionManager;

  int _currentIndex = 0;
  var selectedLang;
  @override
  void initState() {
    sessionManager = SessionManager();



    getSelectedLang().then((value) => {
          selectedLang = value,
          print('Selected Lang in plan submit ${value.toString()}')
        });
  }//initState
Future<String> getSelectedLang() async {
    return await sessionManager.selectedLang;
  }

  Future<String> getSuperVisorInfo() async {
    return await sessionManager.supervisorInfo;
  }

  Future<dynamic> getLeaveRecord() async {
    // return await sessionManager.supervisorInfo;
    return await repository.getLeaveRecord();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Status")),
      body: new ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i) {
          return Container(
            height: 130,
            child: Card(
//                color: Colors.blue,
              elevation: 10,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: AssetImage('images/hacker.jpeg'),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ]),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Looks like a RaisedButton'),
                      );
                      // return showDialog<void>(
                      //   context: context,
                      //     barrierDismissible: false,
                      //     builder: (BuildContext conext) {
                      //     return AlertDialog(
                      //       title: Text('Not in stock'),
                      //       content:
                      //           const Text('This item is no longer available'),
                      //       actions: <Widget>[
                      //         FlatButton(
                      //           child: Text('Ok'),
                      //           onPressed: () {
                      //             Navigator.of(context).pop();
                      //           },
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // );
                    },
                    child: Container(
                        padding: EdgeInsets.all(30.0),
                        child: Chip(
                          label: Text('@anonymous'),
                          shadowColor: Colors.blue,
                          backgroundColor: Colors.green,
                          elevation: 10,
                          autofocus: true,
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      drawer: createDrawer(context),
    );
  }
}

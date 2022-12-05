import 'package:buroleave/LeaveModuleUserInterface/createDrawer.dart';
import 'package:flutter/material.dart';

class LeaveDashboard extends StatefulWidget {
  static const String routeName = '/leaveDashboard';
  static route() => MaterialPageRoute(
      builder: (_) => LeaveDashboard(
          status: "status",
          adate: "adate",
          startdate: "startdate",
          enddate: "enddate",
          reason: "reason"));
  static const String screen_title = 'leaveDashboard';
  final String status;
  final String adate;
  final String startdate;
  final String enddate;
  final String reason;

  const LeaveDashboard(
      {Key? key,
      required this.status,
      required this.adate,
      required this.startdate,
      required this.enddate,
      required this.reason})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyLeaveDashboard();
  }
}

class MyLeaveDashboard extends State<LeaveDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: SingleChildScrollView(
       child: Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Dashboard",
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Apply date  ",
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 0),
                child: Text(
                  "date range",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 8),
                child: Text(
                  "Leave REASON",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            
            
       
            
            ],
          ),
          
        ),
     
      ),
      drawer: createDrawer(context),
    );
  }
}

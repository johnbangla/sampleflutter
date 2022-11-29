import 'package:buroleave/BackendAPI/ApiServices.dart';
import 'package:buroleave/LeaveModuleUserInterface/createDrawer.dart';
import 'package:flutter/material.dart';

class ReportsView extends StatelessWidget {
  static const String routeName = '/reports';

  @override
  Widget build(BuildContext context) {
    ApiService apidata = new ApiService();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reports'),
          centerTitle: true,
        ),
        drawer: createDrawer(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Loading Data ...'),
            
          ],
        ),
      ),
    );
  }
}

import 'package:buroleave/LeaveModuleUserInterface/createDrawer.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  static const String routeName = '/categories';
  static const String screen_title = 'Leave prediction';
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('$screen_title'),
        centerTitle: true,
      ),
      drawer: createDrawer(context),
    ));
  }
}

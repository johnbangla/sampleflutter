import 'package:flutter/material.dart';
import 'package:buroleave/config/routes.dart';

Widget createDrawer(BuildContext context) {
  return Drawer(
      child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      Container(
        color: Theme.of(context).canvasColor,
        child: DrawerHeader(
          child: Text(
            'Menu',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
         ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text('Apply For leave'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routes.applyleave);
          }),
      ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text('Leave History'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routes.transaction);
          }),
      ListTile(
          leading: Icon(Icons.pie_chart),
          title: Text('Reports'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routes.reports);
          }),
      ListTile(
          leading: Icon(Icons.category),
          title: Text('Leave Prediction'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routes.categories);
          }),
      ListTile(
          leading: Icon(Icons.movie),
          title: Text('This Month Movie'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routes.movies);
          }),
      ListTile(
          leading: Icon(Icons.computer),
          title: Text('All Country'),
          onTap: () {
            Navigator.pushReplacementNamed(context, routes.countries);
          }),
    ],
  ));
}

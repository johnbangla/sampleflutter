import 'package:buroleave/Pages/list_country.dart';
import 'package:buroleave/Pages/list_data.dart';
import 'package:buroleave/ui/leavePredictionView.dart';
import 'package:buroleave/ui/ApplyforLeave.dart';
import 'package:buroleave/ui/ReportsView.dart';
import 'package:buroleave/ui/leaveHistory.dart';
import 'package:buroleave/ui/createDrawer.dart';
import 'package:flutter/material.dart';
import 'package:buroleave/config/routes.dart';







void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Smart Leave Management System';

  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      title: appTitle,
      home: const MyHomePage(title: appTitle),
       routes: {
        routes.transaction: (context) => TransactionView(),
        routes.categories: (context) => CategoriesView(),
        routes.reports: (context) => ReportsView(),
        routes.applyleave: (context) => FormScreen(),
        routes.movies:(context) => PopularMovieListPages(),
        routes.countries:(context) => PopularCountryListPages(),
       },
       
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text('LMS @copy right Buro-2022'),
        
      ),
      drawer:createDrawer(context),
  

      
    );
  }
}
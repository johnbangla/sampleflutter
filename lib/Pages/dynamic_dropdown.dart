// import 'package:buroleave/repository/network/buro_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';



// class Dependentdropdown extends StatefulWidget {
//   const Dependentdropdown({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<Dependentdropdown> {
//   List categoryItemlist = [];
//   var repository = new BuroRepository();

//   Future getAllCategory() async {
//     categoryItemlist = (await repository.getDistricttList()) as List;
//   }

//   @override
//   void initState() {
//     super.initState();
//     getAllCategory();
//   }

  // var dropdownvalue;


  // Widget mydependentdropdown()  {
  //   return Container(
    
     
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           DropdownButton(
  //             hint: Text('hooseNumber'),
  //             items: categoryItemlist.map((item) {
  //               return DropdownMenuItem(
  //                 value: item['districtCode'].toString(),
  //                 child: Text(item['districtName'].toString()),
  //               );
  //             }).toList(),
  //             onChanged: (newVal) {
  //               setState(() {
  //                 dropdownvalue = newVal;
  //               });
  //             },
  //             value: dropdownvalue,
  //           ),
  //         ],
  //       ),
     
  //   );
  // }
//}

import 'dart:convert';

import 'package:alert/alert.dart';
import 'package:buroleave/Models/LeaveModel.dart';
import 'package:buroleave/Models/Leaveinfo.dart';
import 'package:buroleave/Models/common_country/district.dart';
import 'package:buroleave/Models/common_country/thana.dart';

import 'package:buroleave/repository/database/database_handler.dart';
import 'package:buroleave/repository/network/buro_repository.dart';

import 'package:buroleave/sessionmanager/session_manager.dart';
import 'package:buroleave/theme/colors.dart';
import 'package:buroleave/theme/styles.dart';
import 'package:buroleave/LeaveModuleUserInterface/MyCalendar.dart';
import 'package:buroleave/LeaveModuleUserInterface/createDrawer.dart';
import 'package:buroleave/LeaveModuleUserInterface/mycountry.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Models/common_country/division.dart';
import 'package:http/http.dart' as http;

import 'leave_wigets.dart/country_state.dart';

//Class start here

class FormScreen extends StatefulWidget {
  static const String routeName = '/applyleave';
  static route() => MaterialPageRoute(builder: (_) => FormScreen());

  // const FormScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
//special R&D
  // ignore: unnecessary_new
  DateTimeRange dtrange = new DateTimeRange(
      start: DateTime(2022, 11, 5), end: DateTime(2022, 12, 5));

//Special r&D

  //Variable declerayion Here
  String? _ramainday;
  String? _remainparking;
  String? _resons;
  String? _departname;

  String? selectedValueforleavetype = null; // for leave type
  String? selectedValuefordelegateusers = null; // for delegate users

//For date range selection

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  //21/11/2022
  String supervisorName = '';
// var repository = BuroRepository();
  late SessionManager sessionManager;

  int _currentIndex = 0;
  var selectedLang;
  late DataBaseHandler handler;
  //21/11/2022
//For Date range selection

  //for built in state city
  // String countryValue = "";
  // String stateValue = "";
  // String cityValue = "";
  // String address = "";

  String? countryValue;
  String? stateValue;
  String? cityValue;

  //for state city

  //for state city

  //working variable for country division district city 4/12/2022
  String? countryNAme;
  String? divisionName;
  String? districtName;
  String? thanaName;
    String? villageName;

  bool isChecked = false;
  bool showErrorMessage = false;
  String? _diff;

  DateTime? firstdate;
  DateTime? seconddate;

//R & D
  int leaveCount = 0;
  List leaves = [];
  List<String> myleavelist = [];
  dynamic _selectedLeave; // Option 2

  var repository = BuroRepository();
  //For clountry Division city and Thana variable
  List<String> districtItemlist = [];
  dynamic _selectedDistrict;

  //Thana list Data
  List<String> thanaItemlist = [];
  dynamic _thanaitem;

//for country state city
  String? idProv;
  String? idKab;
  String? idKec;
//for country state city
//R & D
  @override
  // Future<void> initState() async {
  void initState() {
    sessionManager = SessionManager();

    this.handler = DataBaseHandler();
    getSuperVisorInfo().then((value) => {
          supervisorName = value,
          setState(() {}),
        });

    getSelectedLang().then((value) => {
          selectedLang = value,
          print('Selected Lang in plan submit ${value.toString()}')
        });

    getLeaveTypeDataForApply().then((value) => {
          value.data.forEach((element) {
            // myleavelist = element.leaveTypeName as List;

            print(element.leaveTypeName);
            // myleavelist.add(element.leaveTypeName  + '\n' + 'Remain' + element.remaining.toString());
            myleavelist.add(element.leaveTypeName +
                ' Remain ' +
                element.remaining.toString());

            // print(element.leaveTypeName +"Remaining " + element.remaining.toString());
          })
        });

    // getBranchListFromDatabase().then((value) => () {
    //       //print('Value Length ${value.length}');
    //       value.asMap().forEach((key, value) {
    //         //print(" Branch Name ${value.name}");
    //       });
    //     });

    // initialize();

    // getDistricListAPI().then((value) => {
    //       value.data?.forEach((element) {
    //         districtItemlist.add(element.districtName.toString());

    //         // print(element.leaveTypeName +"Remaining " + element.remaining.toString());
    //       })
    //     });

    // getThanaListbydistrict(_selectedDistrict).then((value) => {
    //       value.data?.forEach((element) {
    //         thanaItemlist.add(element.thanaName.toString());

    //         //  print(element.thanaName.toString());
    //       })
    //     });

    super.initState();
  }

  Future<String> getSelectedLang() async {
    return await sessionManager.selectedLang;
  }

  Future<String> getSuperVisorInfo() async {
    return await sessionManager.supervisorInfo;
  }

  Future<Leaveinfo> getLeaveTypeDataForApply() async {
    // return await sessionManager.supervisorInfo;
    return await repository.getLeavetList();
  }

  //Loading country division city thana data from DB
  // Future<District> getDistricListAPI() async {
  //   return await repository.getDistricttList();
  // }

  //The below code is responsible to retrieve list of Thana by provising District Name
  // Future<Thana> getThanaListbydistrict(var district) async {
  //   return await repository.getThanaListbydistrict(district);
  // }

  //Loading country division city thana data from DB
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Country
  //State city and thana

  var dropdownvalue;
  var dropdownthanavalue;

  // Widget _MyCountryDivision() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       FutureBuilder<District>(
  //         future: getDistricListAPI(),
  //         builder: (context, snapshot) {
  //           // if (snapshot.hasData) {
  //           //   var data = snapshot.data!;
  //           return DropdownButton(
  //             // Initial Value
  //             value: dropdownvalue,

  //             // Down Arrow Icon
  //             icon: const Icon(Icons.keyboard_arrow_down),

  //             // Array list of items
  //             items: districtItemlist.map((String items) {
  //               return DropdownMenuItem(
  //                 value: items,
  //                 child: Text(items),
  //               );
  //             }).toList(),
  //             // After selecting the desired option,it will
  //             // change button value to selected value
  //             onChanged: (newValue) {
  //               setState(() {
  //                 dropdownvalue = newValue!;
  //               });
  //               getThanaListbydistrict(newValue.toString());
  //             },
  //           );
  //           //}

  //           // else {
  //           //   return const CircularProgressIndicator();
  //           // }
  //         },
  //       ),

  // FutureBuilder<Thana>(
  //   future: getThanaListbydistrict('Bandarban'),
  //   builder: (context, snapshot) {
  //     // if (snapshot.hasData) {
  //     //   var data = snapshot.data!;
  //     return DropdownButton(
  //       // Initial Value
  //       value: dropdownthanavalue,

  //       // Down Arrow Icon
  //       icon: const Icon(Icons.keyboard_arrow_down),

  //       // Array list of items
  //       items: thanaItemlist.map((String items) {
  //         return DropdownMenuItem(
  //           value: items,
  //           child: Text(items),
  //         );
  //       }).toList(),
  //       // After selecting the desired option,it will
  //       // change button value to selected value
  //       onChanged: (newValue) {
  //         setState(() {
  //           dropdownthanavalue = newValue!;
  //         });
  //       },
  //     );
  //     // }
  //     // else {
  //     //   return const CircularProgressIndicator();
  //     // }
  //   },
  // ),

//         DropdownButton(
//      hint: const Text('Choose District'), // Not necessary for Option 1
//      value: _selectedDistrict,
//      onChanged: (newValue) {
//        setState(() {
//        _selectedDistrict = newValue.toString();

// //testing for cascasde dropdown by using API 29/11/2022
// getThanaListbydistrict(_selectedDistrict).then((value) => {
//           value.data?.forEach((element) {
//           thanaItemlist.add(element.thanaName.toString() );

//           })
//         });

//        });
//      },
//      items: districtItemlist.map((district) {
//        return DropdownMenuItem(
//          value: district,
//          child: Text(district, overflow: TextOverflow.visible),
//        );
//      }).toList(),
//     ),

  //  DropdownButton(
  //  hint: const Text('Choose Thana'), // Not necessary for Option 1
  //  value: _thanaitem,
  //  onChanged: (newValue) {
  //    setState(() {
  //    _thanaitem = newValue.toString();
  //    });
  //  },
  //  items: thanaItemlist.map((thana) {
  //    return DropdownMenuItem(
  //      value: thana,
  //      child: Text(thana, overflow: TextOverflow.visible),
  //    );
  //  }).toList(),
  // ),
  // ],
  //);
//  }

  Widget _buildinitialLeavetype() {
    return DropdownButton(
      hint: Text('Please Choose Leave Type'), // Not necessary for Option 1
      value: _selectedLeave,
      onChanged: (newValue) {
        setState(() {
          _selectedLeave = newValue.toString();
        });
      },
      items: myleavelist.map((leave) {
        return DropdownMenuItem(
          child: new Text(leave, overflow: TextOverflow.visible),
          value: leave,
        );
      }).toList(),
    );
  }

// This is for RECEIPENT NAME WIGET 21/11/2022
  Widget _buildReceipent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipient',
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: ColorResources.GREY_DARK_SIXTY),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            ' $supervisorName ',
            style: Styles.listHeaderTextStyle,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
//tThis is for receipent name Wiget

//
//  Date range fucntions
//Date range Function
//Test 22/11/2022

//The below code is responsible for fetching leave sample Data
  List<DropdownMenuItem<String>> get LeaveTypedropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Special Leave"), value: "Special Leave"),
      DropdownMenuItem(child: Text("Prov.Staff Leave"), value: "Staff Leave"),
      DropdownMenuItem(child: Text("Festival Leave"), value: "Festival Leave"),
      DropdownMenuItem(
          child: Text("Leave without Pay"), value: "Leave without Pay"),
      DropdownMenuItem(
          child: Text("Accidental without Pay"),
          value: "Accidental without Pay"),
    ];
    return menuItems;
  }

  //The below code is responsible for fetching Delegate sample Data
  List<DropdownMenuItem<String>> get LeavedelegatedropdownItemsfordelegate {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Shainor"), value: "Shainor"),
      DropdownMenuItem(child: Text("MAmun"), value: "MAmun"),
      DropdownMenuItem(child: Text("Ifty"), value: "Ifty"),
      DropdownMenuItem(child: Text("Shakir"), value: "Shakir"),
    ];
    return menuItems;
  }

  Widget _buildlLeavetype() {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 26, 155, 54),
        ),
        validator: (value) => value == null ? "Select a Leave Type" : null,
        dropdownColor: Color.fromARGB(255, 6, 196, 180),
        value: selectedValueforleavetype,
        onChanged: (String? newValue) {
          setState(() {
            selectedValueforleavetype = newValue!;
          });
        },
        // items: LeaveTypedropdownItems);
        items: myleavelist.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }

  Widget _buildDayRemain() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Day(s)Remain'),
      maxLength: 3,
      // validator: (String? value) {
      //   if (value!.isEmpty) {
      //     return 'Name is Required';
      //   }

      //   return null;
      // },
      onSaved: (String? value) {
        _ramainday = value;
      },
    );
  }

  Widget _buildParking() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Day(s)Parking'),
      maxLength: 3,
      // validator: (String? value) {
      //   if (value!.isEmpty) {
      //     return 'Name is Required';
      //   }

      //   return null;
      // },
      onSaved: (String? value) {
        _remainparking = value;
      },
    );
  }

  // Widget _buildDateRangeCalendar() {
  //   return SfDateRangePicker(
  //     onSelectionChanged: _onSelectionChanged,
  //     selectionMode: DateRangePickerSelectionMode.range,
  //     initialSelectedRange: PickerDateRange(
  //         DateTime.now().subtract(const Duration(days: 4)),
  //         DateTime.now().add(const Duration(days: 3))),
  //   );
  // }

  //Smart Calendar Widget
  Widget _buildsmartCalendar() {
    final strt = dtrange.start;
    final dend = dtrange.end;
    final daydiff = dtrange.duration;

    Future pickDaterange() async {
      DateTimeRange? newdatetimerng = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          initialDateRange: dtrange);
      if (newdatetimerng == null) return;
      setState(() => (dtrange = newdatetimerng));
    }

    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Choose Date range',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 16),
          const SizedBox(width: 12),
          IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                pickDaterange();
              }),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Expanded(
                    child: ElevatedButton(
                  onPressed: pickDaterange,
                  child: Text('${strt.year}/${strt.month}/${strt.day}'),
                )),
                const SizedBox(width: 12),
                Expanded(
                    child: ElevatedButton(
                        onPressed: (() => {}),
                        child: Text('${dend.year}/${dend.month}/${dend.day}'))),
                const SizedBox(height: 16),
                Expanded(child: Text('${daydiff.inDays}days'))
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Reason Name
  Widget _buildReasons() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Reason'),
      maxLength: 50,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Leave Reason is Required';
        }

        //   return null;
      },
      onSaved: (String? value) {
        _resons = value;
      },
    );
  }

  //Departname Name
  Widget _buildDepartnamename() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Departname'),
      maxLength: 3,
      // validator: (String? value) {
      //   if (value!.isEmpty) {
      //     return 'Name is Required';
      //   }

      //   return null;
      // },
      onSaved: (String? value) {
        _departname = value;
      },
    );
  }

//For delegate users
  Widget _buildDropdowndownforDelegateuserlist() {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.blueAccent,
        ),
        validator: (value) => value == null ? "Select a country" : null,
        dropdownColor: Colors.blueAccent,
        value: selectedValuefordelegateusers,
        onChanged: (String? newValue) {
          setState(() {
            selectedValuefordelegateusers = newValue!;
          });
        },
        items: LeavedelegatedropdownItemsfordelegate);
  }

//For State country and city

  Widget _builderStateCity() {
    return SelectState(
      // style: TextStyle(color: Colors.red),
      onCountryChanged: (value) {
        setState(() {
          countryValue = value;
        });
      },
      onStateChanged: (value) {
        setState(() {
          stateValue = value;
        });
      },
      onCityChanged: (value) {
        setState(() {
          cityValue = value;
        });
      },
    );
    // InkWell(
    //     onTap: () {
    //       print('country selected is $countryValue');
    //       print('country selected is $stateValue');
    //       print('country selected is $cityValue');
    //     },
    //     child: Text(' Check'));
  }

//Final working depenedent dropdown 2/12/2022
  Widget _country_division_district_city() {
    return CountryDropdown();
  }

//Final Working Depenedent Dropdown

//For  check box

  Widget _buildcheckterms() {
    return Checkbox(
      checkColor: Colors.white,
      // fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }

//For Delegate users

//For country state final testing on 5/12/2022
  @override
  Widget _Myman(BuildContext context) {
    var idProv; //for divison id pass
    var idKab; //for district id pass

    return Column(
      children: [
        DropdownSearch(
          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          mode: Mode.MENU,
           onChanged:(value) => { countryNAme = value?.toString()} ,
          items: ["Bangladesh"],
        ),
        DropdownSearch<Division>(
          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          mode: Mode.MENU,
         
          showSearchBox: false,

          //  onChanged: (value) => idProv = value?.divisionCode.toString(),
          onChanged: (value) => {
            idProv = value?.divisionCode.toString(),
            divisionName = value?.name.toString()
          },

          dropdownBuilder: (context, selectedItem) =>
              Text(selectedItem?.name ?? ""),

          popupItemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.name),
          ),
          onFind: (text) async {
            var response = await repository.getDivisionList();

            if (response.statusCode != 200) {
              return [];
            }
            List allProvince =
                (json.decode(response.body) as Map<String, dynamic>)["data"];
            //  List allProvince =
            //     (response.body as Map<String, dynamic>)["data"];

            List<Division> allModelProvince = [];
            allProvince.forEach((element) {
              allModelProvince.add(
                Division(
                    id: element["id"].toString(),
                    name: element["divisionName"],
                    divisionCode: element["divisionCode"]),
              );
            });
            return allModelProvince;
          },
        ),
        DropdownSearch<District>(
          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          mode: Mode.MENU,
          // showSearchBox: true,
          onChanged: (value) => {
            idKab = value?.idProvinsi,
            districtName = value?.name.toString()  //for saving district name
          },
          dropdownBuilder: (context, selectedItem) =>
              Text(selectedItem?.name ?? ""),
          popupItemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.name),
          ),
          onFind: (text) async {
            var response = await repository.getDistricttListByDivision(idProv);

            if (response.statusCode != 200) {
              return [];
            }
            List allCity =
                (json.decode(response.body) as Map<String, dynamic>)["data"];
            List<District> allModelCity = [];
            allCity.forEach((element) {
              allModelCity.add(
                District(
                    id: element['id'].toString(),
                    idProvinsi: element['districtCode'].toString(),
                    name: element['districtName'].toString(),
                    divisionId: element['divisionId'].toString()),
              );
            });
            return allModelCity;
          },
        ),
        DropdownSearch<Thana>(
          // dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          // ),
          mode: Mode.MENU,
          // showSearchBox: true,
          // onChanged: (value) => idKec = value?.id,  //Please enable if village is needed accordingly
           onChanged: (value) => {
           
            thanaName = value?.name.toString()  //for saving district name
          },
          dropdownBuilder: (context, selectedItem) =>
              Text(selectedItem?.name ?? ""),
          popupItemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.name),
          ),
          onFind: (text) async {
            var response = await repository.getThanaListbydistrict(idKab);

            if (response.statusCode != 200) {
              return [];
            }
            List allDistrict =
                (json.decode(response.body) as Map<String, dynamic>)["data"];
            List<Thana> allModelDistrict = [];
            allDistrict.forEach((element) {
              allModelDistrict.add(
                Thana(
                  id: element["id"].toString(),
                  idKabupaten: element["districtId"].toString(), //city id
                  name: element["thanaName"],
                ),
              );
            });
            return allModelDistrict;
          },
        ),
      ],
    );
  }


//For Country State



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apply For Leave")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildReceipent(),
                // _Testdropdown(),  working
                // _buildinitialLeavetype(), working
                _buildsmartCalendar(),
                _buildlLeavetype(),
                //  _buildDayRemain(),  working
                // _buildParking(),
                // _buildDateRangeCalendar(),

                _buildReasons(),
                // _buildDepartnamename(),
                // _buildDropdowndownforDelegateuserlist(),
                // _MyCountryDivision(),
                //_builderStateCity(),

                //_country_division_district_city(),
                _Myman(context),
                _buildcheckterms(),

                // _buildPassword(),
                // _builURL(),
                // _buildPhoneNumber(),
                //_buildCalories(),
                SizedBox(height: 100),
                ElevatedButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Color.fromARGB(255, 52, 0, 134), fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    if (isChecked) {
                      _formKey.currentState!.save();

                      //Six fields are manadatory for tracking leave info .
                      print(selectedValueforleavetype); //Leave type  1
                      //  print(_ramainday); //from db        //no  need save
                      //  To convert int from string value
                      int intValue = int.parse(selectedValueforleavetype!
                          .replaceAll(RegExp('[^0-9]'), ''));
                      print(intValue.toString());
                      ////  To convert int from string value

                      print(_remainparking); //from db    //no need save
                      print(dtrange.start); //  start date for leave   2
                      print(dtrange.end); //end date for leave     3
                      print(dtrange.duration.inDays
                          .toString()); //No of days of leave +1  4
                      print(_resons); // Leave Reason a story   5
                      //print(_departname); //from db   //no need
                      print(isChecked); //accept term no need
                      print("Address" + countryNAme.toString() + divisionName.toString() + districtName.toString() + thanaName.toString());
                      // print(
                      //     '$countryValue , $stateValue, $cityValue'); //Address of Leave   6

                      //saving leave apply data to db
                      // Employee = dd = Employee(id: , firstName: firstName, lastName: lastName, email: email, phone: phone, birthDate: birthDate, title: title, dept: dept)
                      LeaveModel obj = LeaveModel(
                          id: 20,
                          leave_type: selectedValueforleavetype.toString(),
                          leave_fromDate: dtrange.start.toString(),
                          leave_toDate: dtrange.end.toString(),
                          leave_totalDuration:
                              (dtrange.duration.inDays + 1).toString(),
                          leave_reasonForLeave: _resons.toString(),
                          leave_addressAll: countryNAme.toString() +
                              "/" +
                              divisionName.toString() +
                              "/" +
                              districtName.toString() + thanaName.toString()
                          // dept: cityValue.toString()

                          );
                      // ApiServicesforLeaveApply applyleaveinstancePOST =
                      //     ApiServicesforLeaveApply();

                      late Future<bool> save =
                          repository.createLeaveRequest(obj);
                      // ignore: unrelated_type_equality_checks
                      if (save == true) {
                        Alert(message: 'Post successfully');
                      } else {
                        Alert(message: 'Network Error');
                      }
                      //Send to API
                      //saving leave apply data to db
                    } else {
                      print('please Accept terms and condistion');
                      Alert(message: 'please Accept terms and condistion')
                          .show();
                    }

                    //Send to API
                  },
                )
              ],
            ),
          ),
        ),
      ),
      drawer: createDrawer(context),
    );
  }
}

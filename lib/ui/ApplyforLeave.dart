import 'package:alert/alert.dart';
import 'package:buroleave/Models/Leaveinfo.dart';
import 'package:buroleave/repository/database/database_handler.dart';
import 'package:buroleave/repository/network/buro_repository.dart';
import 'package:buroleave/sessionmanager-prev/session_manager.dart';
import 'package:buroleave/theme/colors.dart';
import 'package:buroleave/theme/styles.dart';
import 'package:buroleave/ui/MyCalendar.dart';
import 'package:buroleave/ui/createDrawer.dart';
import 'package:buroleave/ui/mycountry.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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

  bool isChecked = false;
  bool showErrorMessage = false;
  String? _diff;

  DateTime? firstdate;
  DateTime? seconddate;

//R & D
  int leaveCount = 0;
  List leaves = [];
  List myleavelist = [];
  dynamic _selectedLocation; // Option 2
  // PopularMovieService service = PopularMovieService();
  var repository = BuroRepository();
  // Future initialize() async {
  //   leaves = [];
  //   leaves = (await repository.getLeavetList()) as List;
  //   print(leaves);
  //   setState(() {
  //     leaveCount = leaves.length;
  //     leaves = leaves;
  //   });
  // }

  // @override
  // void initState() {
  //   service = PopularMovieService();
  //   initialize();
  //   super.initState();
  // }

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

    getDataForApply().then((value) => {
          value.data.forEach((element) {
            myleavelist = (element.leaveTypeName +
                "Remaining " +
                element.remaining.toString()) as List;
            print(myleavelist);

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
    super.initState();
  }

  Future<String> getSelectedLang() async {
    return await sessionManager.selectedLang;
  }

  Future<String> getSuperVisorInfo() async {
    return await sessionManager.supervisorInfo;
  }

  Future<Leaveinfo> getDataForApply() async {
    // return await sessionManager.supervisorInfo;
    return await repository.getLeavetList();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildinitialLeavetype() {
    return DropdownButton(
      hint: Text('Please choose a location'), // Not necessary for Option 1
      value: _selectedLocation,
      onChanged: ( newValue) {
        setState(() {
          _selectedLocation = newValue.toString();
        });
      },
      items: myleavelist.map((location) {
        return DropdownMenuItem(
          child: new Text(location),
          value: location,
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
          fillColor: Colors.blueAccent,
        ),
        validator: (value) => value == null ? "Select a Leave Type" : null,
        dropdownColor: Colors.blueAccent,
        value: selectedValueforleavetype,
        onChanged: (String? newValue) {
          setState(() {
            selectedValueforleavetype = newValue!;
          });
        },
        items: LeaveTypedropdownItems);
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
      // validator: (String? value) {
      //   if (value!.isEmpty) {
      //     return 'Name is Required';
      //   }

      //   return null;
      // },
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
                _buildinitialLeavetype(),
                _buildlLeavetype(),
                _buildDayRemain(),
                // _buildParking(),
                // _buildDateRangeCalendar(),
                _buildsmartCalendar(),
                _buildReasons(),
                // _buildDepartnamename(),
                // _buildDropdowndownforDelegateuserlist(),
                _builderStateCity(),
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
                      print(_ramainday); //from db        //no  need save
                      print(_remainparking); //from db    //no need save
                      print(dtrange.start); //  start date for leave   2
                      print(dtrange.end); //end date for leave     3
                      print(dtrange.duration.inDays
                          .toString()); //No of days of leave +1  4
                      print(_resons); // Leave Reason a story   5
                      //print(_departname); //from db   //no need
                      print(isChecked); //accept term no need
                      print(
                          '$countryValue , $stateValue, $cityValue'); //Address of Leave   6

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

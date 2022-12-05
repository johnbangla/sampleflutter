import 'dart:convert';

import 'package:buroleave/Models/common_country/district.dart';
import 'package:buroleave/Models/common_country/division.dart';
import 'package:buroleave/Models/common_country/thana.dart';
import 'package:buroleave/repository/network/buro_repository.dart';

import 'package:buroleave/sessionmanager/session_manager.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CountryDropdown extends StatefulWidget {
  // const FormScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return Country_State_City();
  }
}

class Country_State_City extends State<CountryDropdown> {
  //Declare country division district
  var country;
  var division;
  var district;
  var city;

  //Declare COuntry Division District
  var repository = BuroRepository();
  late SessionManager sessionManager;

  @override
  void initState() {
    sessionManager = SessionManager();
  }

  @override
  Widget build(BuildContext context) {
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
          // onChanged: (value) => idKec = value?.id,
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
}

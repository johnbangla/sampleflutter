import 'package:buroleave/Pages/details_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../BackendAPI/ApiServiceonly.dart';
import '../ui/createDrawer.dart';
//class Name: PopularCountryListPages  27.10.2022 time 11:50

//This Class is responsible for showing List od country

//Method Name initialize() saving movies count and movies data by calling http calling using setState

class PopularCountryListPages extends StatefulWidget {

    //This is for routing
    static const String routeName = '/listofcountry';
  const PopularCountryListPages({Key? key}) : super(key: key);

  @override
  State<PopularCountryListPages> createState() => _PopularCountryListPagesState();
}

//Class name :  
class _PopularCountryListPagesState extends State<PopularCountryListPages> {
  int countriesCount = 0;
  List countries = [];
  PopularMovieService service1 = PopularMovieService();
  
//Fething dat from Api service from online 
  Future initialize() async {
    countries = [];
    countries = (await service1.getPopularCountries())!;
    setState(() {
      countriesCount = countries.length;
      countries = countries;
    });
  }

  @override
  void initState() {
    service1 = PopularMovieService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('countriesCount $countriesCount');
    }
    if (kDebugMode) {
      print('countries $countries');
    }
    const image = "https://image.tmdb.org/t/p/w500";
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text(
          'Popular countries',
        ),
      ),
       drawer: createDrawer(context),
      body: ListView.builder(
     
        itemCount: countriesCount,
        itemBuilder: (context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                // backgroundImage:
                //     NetworkImage(image + countries[position].posterPath),
              ),
              title: Text(
               countries[position].native_name.toString(),
              ),
              subtitle: Text(
                'Name: ${countries[position].english_name.toString()}',
              ),
              onTap: () {
                if (kDebugMode) {
                  // print(countries[position].title);
                  // print(countries[position].voteAverage.toString());
                  // print(image + countries[position].posterPath.toString());
                  // print(countries[position].overview.toString());
                }
                //This below code is responsible for Details Data
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PopularMovieDetailPages(
                //       title: countries[position].iso31661.toString(),
                //        englishName: countries[position].englishName.toString(),
                //         nativeName: countries[position].nativeName.toString(),
                     
                //       overview: countries[position].overview,
                //     ),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}

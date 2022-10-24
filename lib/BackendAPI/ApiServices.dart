import 'dart:convert';

import 'package:http/http.dart' as client;

import 'package:buroleave/Models/models.dart';

class ApiService {
  final String baseUrl = "https://reqres.in/api/user";

//Reading API data very basic exmaple

  Future<List<UserModel>> userDetailsData() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return userModelFromJson(jsonDecode(response.body));
    }
    else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  }

  Future<UserModel> fetchAlbum() async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return UserModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
}
// //Posting Data to API very Basic Exmaple
//   Future<bool> createBrands(UserModel data) async {
//     final response = await client.post(
//       "$baseUrl/api/Brands",
//       headers: {"content-type": "application/json"},
//       body: BrandsToJson(data),
//     );
//     if (response.statusCode == 201) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// //Update Data to Api Very basic Exmaple
//   Future<bool> updateBrands(UserModel data) async {
//     final response = await client.put(
//       "$baseUrl/api/Brands/${data.id}",
//       headers: {"content-type": "application/json"},
//       body: BrandsToJson(data),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// //Delete Data Using API Very basic Exmple
//   Future<bool> deleteBrands(int id) async {
//     final response = await client.delete(
//       "$baseUrl/api/Brands/$id",
//       headers: {"content-type": "application/json"},
//     );
//     if (response.statusCode == 204) {
//       return true;
//     } else {
//       return false;
//     }
//   }



import 'package:http/http.dart' as http;

import '../Models/brands_model.dart';

class ApiService {
  final String baseUrl = "https://localhost:7206";
  // http http = http();

  Future<List<Brands>?> getBrandss() async {
    final response = await http.get(Uri.parse('$baseUrl/api/Brands'));
    if (response.statusCode == 200) {
      return BrandsFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createBrands(Brands data) async {
    final response = await http.post(Uri.parse('$baseUrl/api/Brands'),
     
      headers: {"content-type": "application/json"},
      body: BrandsToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateBrands(Brands data) async {
    final response = await http.put(Uri.parse('$baseUrl/api/Brands/${data.id}'),
      
      headers: {"content-type": "application/json"},
      body: BrandsToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteBrands(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/api/Brands/$id'),

      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}

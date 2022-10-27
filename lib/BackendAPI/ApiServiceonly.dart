import 'dart:convert';

import 'package:buroleave/Models/country_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:http_status_code/http_status_code.dart';

import '../Models/movie_model.dart';

class PopularMovieService {
  final String apiKey = '8cfb855d7b731341ace5b90889b138a1';
  final String baseUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=';
  final String moviebaseUrl =
      'https://api.themoviedb.org/3/configuration/countries?api_key=';
//Get All  Movie List
  Future<List?> getPopularMovies() async {
    final String url = baseUrl + apiKey;

    http.Response result = await http.get(Uri.parse(url));
    if (result.statusCode == StatusCode.OK) {
      if (kDebugMode) {
        print('Successfully get API key from ${url}');
      }
      final jsonResponse = json.decode(result.body);
      if (kDebugMode) {
        // print(jsonResponse.toString());
      }
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((movie) => Movie.fromJson(movie)).toList();

      return movies;
    } else {
      if (kDebugMode) {
        print('Failed to get API key from ${url}');
      }
      return null;
    }
  }

//Get All COuntry list from the save server
  Future<List?> getPopularCountries() async {
    final String url = moviebaseUrl + apiKey;

    http.Response result = await http.get(Uri.parse(url));
    if (result.statusCode == StatusCode.OK) {
      if (kDebugMode) {
        print('Successfully get API key from ${url}');
      }
      final jsonResponse = json.decode(result.body);
      if (kDebugMode) {
         print(jsonResponse.toString());
      }
      final countriesMap = jsonResponse['results'];
      List countries = countriesMap.map((country) => CountryModel.fromJson(country)).toList();

      return countries;
    } else {
      if (kDebugMode) {
        print('Failed to get API key from ${url}');
      }
      return null;
    }
  }
}

import 'dart:convert';

import 'package:csc_picker/model/select_status_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class CountryModel {
  CountryModel({
    required this.id,
    required this.iso31661,
    required this.englishName,
    required this.nativeName,
  });

   final int id;
  final String iso31661;
  final String englishName;
  final String nativeName;

  // Movie.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       title = json['title'],
  //       voteAverage = json['vote_average'] * 1.0,
  //       overview = json['overview'],
  //       posterPath = json['poster_path'];

  CountryModel.fromJson(Map<String, dynamic> json)

      :  id = json['id'],
      iso31661 = json['iso_3166_1'],
        englishName = json["english_name"],
        nativeName = json["native_name"];

  // Map<String, dynamic> toJson() => _$MovieFromJson(this);

  // Map<String, dynamic> _$MovieFromJson(Movie instance) => <String, dynamic>{
  //       'id': instance.id,
  //       'title': instance.title,
  //       'voteAverage': instance.voteAverage,
  //       'overview': instance.overview,
  //       'posterPath': instance.posterPath,
  //     };
  Map<String, dynamic> toJson() => _$CountryFromJson(this);

  Map<String, dynamic> _$CountryFromJson(CountryModel instance) => <String, dynamic>{
        'id': instance.id,
        'iso_3166_1': instance.iso31661,
        'english_name': instance.englishName,
        'native_name': instance.nativeName,
      };
}

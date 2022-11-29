class Thana {
    Thana({
       required this.id,
        required this.thanaName,
       required this.districtId,
    });

    final int id;
    final String thanaName;
    final int districtId;

    factory Thana.fromJson(Map<String, dynamic> json){ 
        return Thana(
        id: json["id"] ,
        thanaName: json["thanaName"] ,
        districtId: json["districtId"] ,
    );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "thanaName": thanaName,
        "districtId": districtId,
    };

}

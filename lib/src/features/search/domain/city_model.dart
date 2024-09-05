class City {
  String cityName;
  double lat;
  double lng;

  City({
    required this.cityName,
    required this.lat,
    required this.lng,
  });

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      cityName: map['cityName'] as String,
      lat: map['latitude'] as double,
      lng: map['longitude'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'lat': lat,
      'lng': lng,
    };
  }
}

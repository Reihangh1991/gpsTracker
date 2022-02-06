class Point {
  final double lat;
  final double lon;
  final String name;

 
  const Point({
    required this.lat,
    required this.lon,
    required this.name,
  });

  double getLat() {return lat;}
  double getLon() {return lon;}
  String getName() {return name;}
  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      name: json['properties']["name"],
      lat: json['geometry']['coordinates'][1],
      lon: json['geometry']['coordinates'][0],
    );
  }
}
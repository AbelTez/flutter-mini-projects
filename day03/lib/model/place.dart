class Place {
  final String imagePath;
  final String placeName;
  final List<dynamic> placeItems;
  final int minOrder;

  Place({
    required this.imagePath,
    required this.placeName,
    required this.placeItems,
    required this.minOrder,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      imagePath: json['placeImage'],
      placeName: json['placeName'],
      placeItems: json['placeItems'],
      minOrder: json['minOrder'],
    );
  }
}
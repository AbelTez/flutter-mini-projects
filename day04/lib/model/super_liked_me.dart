class SuperLikedMe {
  final String name;
  final String imageUrl;
  final bool isActive;
  final String location;
  final int age;

  SuperLikedMe({required this.name, required this.imageUrl, required this.isActive, required this.location, required this.age});

  factory SuperLikedMe.fromJson(Map<String, dynamic> json) {
    return SuperLikedMe(
      name: json['name'],
      imageUrl: json['imageUrl'],
      isActive: json['isActive'],
      location: json['location'],
      age: json['age'],
    );
  }
}

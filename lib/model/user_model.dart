class UserModel {
  String name;
  String email;
  String address;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;
  double? latitude; // Updated field for latitude
  double? longitude; // Updated field for longitude

  UserModel({
    required this.name,
    required this.email,
    required this.address,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
    required this.latitude, // Updated constructor to include latitude
    required this.longitude, // Updated constructor to include longitude
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "address": address,
      "uid": uid,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "profilePic": profilePic,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}

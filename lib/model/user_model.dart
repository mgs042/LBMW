class UserModel {
  final String name;
  final String email;
  final String address;
  final String profilePic;
  final String createdAt;
  final String phoneNumber;
  final String uid;
  UserModel({
    required this.name,
    required this.email,
    required this.address,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
  });
  //from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }
//to map
  Map<String, dynamic> toMAp() {
    return {
      "name": name,
      "email": email,
      "address": address,
      "uid": uid,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "profilePic": profilePic,
    };
  }
}

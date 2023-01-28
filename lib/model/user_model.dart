import 'package:foode_app/model/address_model.dart';

class UserModel {
  final String name;
  final String username;
  final String password;
  final String avatar;
  final String bio;
  final String bith;
  final String email;
  final String gender;
  final String phone;
  final List likes;
  final AddressModel address;

  UserModel(
      {required this.name,
      required this.username,
      required this.password,
      required this.avatar,
      required this.bio,
      required this.bith,
      required this.email,
      required this.gender,
      required this.phone,
      required this.likes,
      required this.address});

  factory UserModel.fromJson(Map data) {
    return UserModel(
        name: data["name"],
        username: data["username"],
        password: data["password"],
        avatar: data["avatar"],
        bio: data["bio"],
        bith: data["bith"],
        email: data["email"],
        gender: data["gender"],
        phone: data["phone"],
        likes: data["likes"],
        address: AddressModel.fromJson(data["address"]));
  }

  toJson() {
    return {
      "name": name,
      "username": username,
      "password": password,
      "avatar": avatar,
      "bio": bio,
      "bith": bith,
      "email": email,
      "gender": gender,
      "phone": phone,
      "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
      "address": address.toJson()
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? email;
  String? uid;
  String? username;
  String? interests;
  String? vk;
  String? telegram;
  String? phone;
  String? photo;
  List<dynamic> subs = [];

  UserModel({this.email, this.uid, this.username, this.interests, this.vk,
    this.telegram, this.phone, this.photo});

  Map<String, dynamic> toMap(UserModel user) {
    var data = Map<String, dynamic>();

    data["email"] = user.email;
    data["uid"] = user.uid;
    data["username"] = user.username;
    data["interests"] = user.interests;
    data["vk"] = user.vk;
    data["telegram"] = user.telegram;
    data["phone"] = user.phone;
    data["photo"] = user.photo;
    data["subs"] = user.subs;

    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    this.email = mapData["email"];
    this.uid = mapData["uid"];
    this.username = mapData["username"];
    this.interests = mapData["interests"];
    this.vk = mapData["vk"];
    this.telegram = mapData["telegram"];
    this.phone = mapData["phone"];
    this.photo = mapData["photo"];
    this.subs = mapData["subs"];
  }
}
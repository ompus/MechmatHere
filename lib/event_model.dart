import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventModel {
  String? creatoruid;
  String? photo;
  String? cat;
  String? name;
  String? desc;
  String? vk;
  String? telegram;
  String? phone;

  EventModel({this.creatoruid, this.photo, this.cat, this.name, this.desc,
    this.vk, this.telegram, this.phone});

  Map<String, dynamic> toMap(EventModel user) {
    var data = Map<String, dynamic>();

    data["creatoruid"] = user.creatoruid;
    data["photo"] = user.photo;
    data["cat"] = user.cat;
    data["name"] = user.name;
    data["desc"] = user.desc;
    data["vk"] = user.vk;
    data["telegram"] = user.telegram;
    data["phone"] = user.phone;

    return data;
  }

  EventModel.fromMap(Map<String, dynamic> mapData) {
    this.creatoruid = mapData["creatoruid"];
    this.photo = mapData["photo"];
    this.cat = mapData["cat"];
    this.name = mapData["name"];
    this.desc = mapData["desc"];
    this.vk = mapData["vk"];
    this.telegram = mapData["telegram"];
    this.phone = mapData["phone"];
  }
}
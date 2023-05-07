import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechmat_tut/event_model.dart';

class EventService {
  final FirebaseAuth _firebaseAuth;
  EventModel eventModel = EventModel();
  final eventRef = FirebaseFirestore.instance.collection("events");

  EventService(this._firebaseAuth);

// 6
  Future<String?> addEventToDB(String? creatoruid, String photo, String? cat, String? name,
  String? desc, String? vk, String? telegram, String? phone) async {
    if (name == "")
      return "Имя мероприятия не может быть пустым"; else
    if (cat == "-1")
      return "Выберите категорию";
    if (vk != "" &&  !RegExp(r"vk.com/+[a-zA-Z0-9.a-zA-Z0-9_]")
        .hasMatch(vk!)) return "Введите ссылку на профиль в ВК в формате vk.com/*"; else
    if (telegram != "" &&  !RegExp(r"t.me/+[a-zA-Z0-9a-zA-Z0-9_]")
        .hasMatch(telegram!)) return "Введите ссылку на профиль в Telegram в формате t.me/*"; else
    if (phone != "" && !(RegExp(r"8+[0-9]{9}").hasMatch(phone!)||
        RegExp(r"\+7+[0-9]{9}").hasMatch(phone))) return "Введите телефон в формате 8********** или +7**********";
    eventModel = EventModel(
        creatoruid: creatoruid, cat: cat, photo: photo, name: name, desc: desc, vk:vk, telegram: telegram, phone: phone);
    await eventRef.doc(name).set(eventModel.toMap(eventModel));
    return "Мероприятие добавлено";// придумать с uid
  }

  Future<String?> reloadEventToDB(String? creatoruid, String photo, String? cat, String? name,
      String? desc, String? vk, String? telegram, String? phone) async {
    if (name == "")
      return "Имя мероприятия не может быть пустым"; else
    if (cat == "-1")
      return "Выберите категорию";
    if (vk != "" &&  !RegExp(r"vk.com/+[a-zA-Z0-9.a-zA-Z0-9_]")
        .hasMatch(vk!)) return "Введите ссылку на профиль в ВК в формате vk.com/*"; else
    if (telegram != "" &&  !RegExp(r"t.me/+[a-zA-Z0-9a-zA-Z0-9_]")
        .hasMatch(telegram!)) return "Введите ссылку на профиль в Telegram в формате t.me/*"; else
    if (phone != "" && !(RegExp(r"8+[0-9]{9}").hasMatch(phone!)||
        RegExp(r"\+7+[0-9]{9}").hasMatch(phone))) return "Введите телефон в формате 8********** или +7**********";
    eventModel = EventModel(
        creatoruid: creatoruid, cat: cat, photo: photo, name: name, desc: desc, vk:vk, telegram: telegram, phone: phone);
    await eventRef.doc(name).set(eventModel.toMap(eventModel));
    return "Мероприятие изменено";// придумать с uid
  }

  Future<List<String>> getNamesByCat(List<String> l, int id) async {
    QuerySnapshot querySnapshot = await eventRef.where("cat", isEqualTo: id.toString()).get();
    for (var docSnapshot in querySnapshot.docs) {
      l.add((docSnapshot.data() as Map<String, dynamic>)["name"]);// по id надо сделать
    }
    return l;
  }

  Future<List<String>> getNamesByUser(List<String> l) async {
    QuerySnapshot querySnapshot = await eventRef.where("creatoruid", isEqualTo: _firebaseAuth.currentUser!.uid).get();
    for (var docSnapshot in querySnapshot.docs) {
      l.add((docSnapshot.data() as Map<String, dynamic>)["name"]);// по id надо сделать
    }
    return l;
  }


  Future<EventModel> getEventByName(String s) async {
    final DocumentSnapshot doc = await eventRef.doc(s).get();

    return EventModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<String> deleteEvent(String name) async {
    final docRef = eventRef.doc(name);
    final updates = <String, dynamic>{
      "creatoruid": FieldValue.delete(),
      "photo": FieldValue.delete(),
      "cat": FieldValue.delete(),
      "name": FieldValue.delete(),
      "desc": FieldValue.delete(),
      "vk": FieldValue.delete(),
      "telegram": FieldValue.delete(),
      "phone": FieldValue.delete(),
    };
    docRef.update(updates);
    eventRef.doc(name).delete();
    return "Мероприятие удалено";
  }

}
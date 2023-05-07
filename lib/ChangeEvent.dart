import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechmat_tut/user_image.dart';
import 'package:mechmat_tut/user_model.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';
import 'event_model.dart';
import 'event_service.dart';
import 'helper.dart';

String x = "";

class ChangeEvent extends StatefulWidget {
  final String name;
  ChangeEvent(Key? key, this.name) : super(key: key);
  @override
  _ChangeEventState createState() => _ChangeEventState();
}

class _ChangeEventState extends State<ChangeEvent> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final eventRef = FirebaseFirestore.instance.collection("events");
  late Future<EventModel> event;
  TextEditingController descController = TextEditingController();
  TextEditingController vkController = TextEditingController();
  TextEditingController telegramController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String imageUrl = '';
  String EventImageUrl = '';
  String EventName = '';
  //String Cat = '';
  /*
  String? vk = '';
  String? telegram = '';
  String? phone = '';*/
  //late Future<UserModel> s;

  void initState() {
    setState(() {
      //s = context
          //.read<AuthenticationService>()
          //.getUserFromDB(context.read<AuthenticationService>().getUser()!.uid);
      event = context.read<EventService>().getEventByName(widget.name);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    x = "-1";
    event.then((result) {
      EventName = result.name ?? "";
      descController.text = result.desc ?? "";
      vkController.text = result.vk ?? "";
      telegramController.text = result.telegram ?? "";
      phoneController.text = result.phone ?? "";
      EventImageUrl = result.photo ?? "";
      //Cat = result.cat!;
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Редактировать мероприятие",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(0),
          child: Center(
              child: Form(
            child: ListView(
              children: [
                const SizedBox(
                  height: 16,
                ),
                UserImage(onFileChanged: (imageUrl) {
                  setState(() {
                    this.imageUrl = imageUrl;
                  });
                }),
                const SizedBox(
                  height: 16,
                ),
                /*Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Введите название мероприятия'),
                            controller: nameController),
                      ),*/
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Введите описание мероприятия'),
                      style: TextStyle(),
                      maxLines: 12,
                      minLines: 5,
                      controller: descController),
                ),
                Padding(padding: const EdgeInsets.all(16.0), child: Cats()),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText:
                                    'ВКонтакте (пустое поле - данные с профиля)'),
                            controller: vkController),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText:
                                    'Telegram (пустое поле - данные с профиля)'),
                            controller: telegramController),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText:
                                    'Телефон (пустое поле - данные с профиля)'),
                            controller: phoneController),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 6.0,
                        primary: Colors.amber, // background
                        onPrimary: Colors.black, // foreground
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                      onPressed: () async {
                        final docRef = eventRef.doc(EventName);

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
                        eventRef.doc(EventName).delete();
                        final result = await context
                            .read<EventService>()
                            .reloadEventToDB(
                                auth.currentUser!.uid,
                            imageUrl == "" ? EventImageUrl: imageUrl,
                                x,
                                EventName,
                                descController.text.trim(),
                                vkController.text.trim() == ""
                                    ? ""
                                    : vkController.text.trim(),
                                telegramController.text.trim() == ""
                                    ? ""
                                    : telegramController.text.trim(),
                                phoneController.text.trim() == ""
                                    ? ""
                                    : phoneController.text
                                        .trim() // добавить проверку
                                );
                        showSnackbar(context, result!);
                        if (result == "Мероприятие изменено")
                          Navigator.pop(context);
                      },
                      child: Text('Сохранить'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          )),
        ));
  }
}

class Cats extends StatefulWidget {
  const Cats({Key? key}) : super(key: key);
  @override
  _CatsState createState() => _CatsState();
}

class _CatsState extends State<Cats> {
  String? selectedCat;
  List<String> CatsList = <String>[
    "Спорт",
    "Учёба",
    "Настолки",
    "Отдам в дар",
    "Игры",
    "Поездки",
    "Другое",
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text(
        'Выберите категорию',
      ),
      isExpanded: true,
      value: selectedCat,
      items: CatsList.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
          ),
        );
      }).toList(),
      onChanged: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          selectedCat = _!;
          x = (CatsList.indexOf(selectedCat!) + 1).toString();
        });
      },
    );
  }
}

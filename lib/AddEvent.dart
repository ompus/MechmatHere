import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechmat_tut/user_image.dart';
import 'package:mechmat_tut/user_model.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';
import 'event_service.dart';
import 'helper.dart';

String x = "";
class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String imageUrl = '';
  String? vk = '';
  String? telegram = '';
  String? phone = '';
  late Future<UserModel> s;

  void initState() {
    setState(() {
      s = context.read<AuthenticationService>().getUserFromDB(context.read<AuthenticationService>().getUser()!.uid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    x = "-1";
    s.then((res){
        vk = res.vk; telegram = res.telegram; phone = res.phone;
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text("Добавить мероприятие",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),),
        body: Padding(
            padding: EdgeInsets.all(0),
            child: Center(
                child: Form(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      UserImage(
                          onFileChanged: (imageUrl){
                            setState(() {
                              this.imageUrl = imageUrl;
                            });
                          }
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Введите название мероприятия'),
                            controller: nameController),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Введите описание мероприятия'),
                            style: TextStyle(), maxLines: 12, minLines: 5,
                            controller: descController),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Cats()),
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
                              final result =  await context
                                  .read<EventService>()
                                  .addEventToDB(auth.currentUser!.uid, imageUrl, x ,nameController.text.trim(),
                                  descController.text.trim(), vk, telegram, phone // добавить проверку
                              );
                              showSnackbar(context, result!);
                              if (result == "Мероприятие добавлено")
                                Navigator.pop(context);
                            },
                            child: Text('Создать мероприятие'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )
            ),)
    );
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
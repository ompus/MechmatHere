import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication_service.dart';
import 'AddEvent.dart';
import 'event_service.dart';
import 'EventDetailPage.dart';

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({Key? key}) : super(key: key);
  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}
class _MyEventsPageState extends State<MyEventsPage>
{
  late Future<List<String>> buf;
  List<String> namesForUser = [];
  User? user;
  @override
  void initState() {
    setState(() {
      user = context.read<AuthenticationService>().getUser();
      buf = context.read<EventService>().getNamesByUser(namesForUser);
    });
    super.initState();
  }

  //callback(){
    //setState(() {
    //});
  //}
  @override
  Widget build(BuildContext context) {
    buf.then((value){
      setState(() {
        namesForUser = value;
      });
    });
    return Scaffold(
        appBar: AppBar(
            title: const Text("Мои мероприятия", style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),
          actions: [
            IconButton(
              icon: Icon(Icons.add), color: Colors.black,
              onPressed: () async{
                await Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AddEvent()
                ));
                namesForUser = [];
                setState(() {
                  buf = context.read<EventService>().getNamesByUser(namesForUser);
                });
              },)],
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: ListView(
              children: namesForUser.map<Widget>((event) {
                return Material(
                  color: Colors.black12,
                  child: InkWell(
                    splashColor: Colors.black12,
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(
                          builder: (context) => EventDetailPage(null, event)));
                      namesForUser = [];
                      setState(() {
                        buf = context.read<EventService>().getNamesByUser(namesForUser);
                      });
                    },
                    // далее указываем в качестве
                    // элемента Container с вложенным Text
                    // Container позволяет указать внутренние (padding)
                    // и внешние отступы (margin),
                    // а также тень, закругление углов,
                    // цвет и размеры вложенного виджета
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                            event,
                            style: Theme.of(context).textTheme.bodyLarge
                        )
                    ),
                  ),
                );
                // map возвращает Iterable объект, который необходимо
                // преобразовать в список с помощью toList() функции
              }).toList(),
            )
        ),
    );
  }
}
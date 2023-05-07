import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechmat_tut/user_model.dart';
import 'package:provider/provider.dart';
import '../authentication_service.dart';
import 'EventDetailPage.dart';

class NotifEventPage extends StatefulWidget {
  const NotifEventPage({Key? key}) : super(key: key);
  @override
  _NotifEventPageState createState() => _NotifEventPageState();
}
class _NotifEventPageState extends State<NotifEventPage>
{
  late Future<UserModel> buf;
  List<dynamic> subs = [];

  @override
  void initState() {
    setState(() {
      buf = context.read<AuthenticationService>().getUserFromDB(context.read<AuthenticationService>().getUser()!.uid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buf.then((value){
      setState(() {
        if (value.subs.isNotEmpty)
        subs = value.subs;
        else { subs = [];}
      });
    });
    return Scaffold(
        appBar: AppBar(
            title: Text('Мои подписки', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: ListView(
              children: subs.map<Widget>((event) {
                return Material(
                  color: Colors.black12,
                  child: InkWell(
                    splashColor: Colors.black12,
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(
                          builder: (context) => EventDetailPage(null, event)));
                      setState(() {
                        buf = context.read<AuthenticationService>().getUserFromDB(context.read<AuthenticationService>().getUser()!.uid);
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
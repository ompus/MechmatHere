import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication_service.dart';
import 'package:mechmat_tut/pages/main_page.dart';
import 'event_service.dart';
import 'EventDetailPage.dart';

class CatDetailPage extends StatefulWidget {
  final int CatID;
  CatDetailPage(Key? key, this.CatID) : super(key: key);
  @override
  _CatDetailPageState createState() => _CatDetailPageState();
}
class _CatDetailPageState extends State<CatDetailPage>
{
  late Future<List<String>> buf;
  List<String> namesForCat = [];

  @override
  void initState() {
    setState(() {
      buf = context.read<EventService>().getNamesByCat(namesForCat, widget.CatID);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    buf.then((value){
      setState(() {
        namesForCat = value;
      });
    });
    final cat = cats[widget.CatID];
    return Scaffold(
        appBar: AppBar(
            title: Text(cat.name, style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: ListView(
              children: namesForCat.map<Widget>((event) {
                return Material(
                  color: Colors.black12,
                  child: InkWell(
                    splashColor: Colors.black12,
                    onTap: () async{
                      await Navigator.push(context, MaterialPageRoute(
                          builder: (context) => EventDetailPage(null, event)));
                      namesForCat = [];
                      setState(() {
                        buf = context.read<EventService>().getNamesByCat(namesForCat, widget.CatID);
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
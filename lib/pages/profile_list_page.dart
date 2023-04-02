import 'package:firebase_auth/firebase_auth.dart';import 'package:flutter/material.dart';import 'package:mechmat_tut/pages/ProfileDetailPage.dart';import 'package:mechmat_tut/pages/ProfilePhotoPage.dart';import '../MyEventsPage.dart';import '../authentication_service.dart';import 'package:provider/provider.dart';import '../user_model.dart';// класс пункта меню страницы профиля,// который будет хранить имя и описание, а также idclass ProfScrElem {  final int id;  String name;  final String desc;  final IconData icon;  ProfScrElem(this.id, this.name, this.desc, this.icon);}// создаем список пунктов меню страницы профиля// final указывает на то, что мы больше// никогда не сможем присвоить имени ProfScrElems// другой список пунктов меню страницы профиляfinal List<ProfScrElem> ProfScrElems = [  ProfScrElem(      0,      "",      "Просмотр профиля в доработке",      Icons.account_circle_outlined  ),  ProfScrElem(      1,      "Мои мероприятия",      "Просмотр мероприятий в доработке",      Icons.insert_invitation  ),  ProfScrElem(      2,      "Настройки",      "Настройки в доработке",      Icons.settings  ),  ProfScrElem(      3,      "Выход",      "Вы действительно хотите выйти?",      Icons.exit_to_app  ),];class ProfileListPage extends StatefulWidget {  const ProfileListPage({Key? key}) : super(key: key);  @override  _ProfileListPageState createState() => _ProfileListPageState();}class _ProfileListPageState extends State<ProfileListPage>{  User? user;  late Future<UserModel> s = context.read<AuthenticationService>().getUserFromDB(user!.uid);  @override  void initState() {    super.initState();    setState(() {      // 2      user = context.read<AuthenticationService>().getUser();    });  }  // build как мы уже отметили, строит  // иерархию наших любимых виджетов  @override  Widget build(BuildContext context) {    s.then((result){      setState(() {        ProfScrElems[0].name = result.username ?? "";      });    });    return Scaffold(      appBar: AppBar(title: const Text("Профиль",        style: TextStyle(            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),        backgroundColor: Colors.amber,),      body: Padding(          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),          // создаем наш список          child: ListView(            children: ProfScrElems.map<Widget>((elem) {              return Material(                color: Colors.black12,                child: InkWell(                  splashColor: Colors.black12,                  onTap: () {                    if (elem.id == 0)                      Navigator.push(context, MaterialPageRoute(                          builder: (context) => ProfilePhotoPage()                      ));                    if (elem.id == 1)                      Navigator.push(context, MaterialPageRoute(                          builder: (context) => MyEventsPage()                      ));                    if (elem.id == 2)                      Navigator.push(context, MaterialPageRoute(                          builder: (context) => ProfileDetailPage(elem.id)                      ));                    if (elem.id == 3)                      context.read<AuthenticationService>().signOut();                  },                  child: Container(                    padding: EdgeInsets.all(5), child: Row(                children: <Widget>[                Icon(                  elem.icon,                  size: 50,                  color: Colors.grey,                ),                  Center(                      child: Text(                          "    "  + elem.name, // сделать нормальный отступ                          style: Theme.of(context).textTheme.bodyLarge))                  ]              ),)                ),              );            }).toList(),          )      ),    );  }}
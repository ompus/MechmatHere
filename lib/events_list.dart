import 'package:flutter/material.dart';// Класс категории, который будет хранить имя, иконку, описание, а также idclass Category {  final int id;  final String name;  final String desc;  final IconData icon;  Category(this.id, this.name, this.desc, this.icon);}// создаем список категорий// final указывает на то, что мы больше// никогда не сможем присвоить имени cats// другой список категорийfinal List<Category> cats = [  Category(      0,      "Официальные",      "В категории пока нет мероприятий",      Icons.business_center_outlined  ),  Category(      1,      "Спорт",      "В категории пока нет мероприятий",      Icons.sports  ),  Category(      2,      "Учёба",      "В категории пока нет мероприятий",      Icons.import_contacts_outlined  ),  Category(      3,      "Настолки",      "В категории пока нет мероприятий",      Icons.casino_outlined  ),  Category(      4,      "Отдам в дар",      "В категории пока нет мероприятий",      Icons.redeem_outlined  ),  Category(      5,      "Игры",      "В категории пока нет мероприятий",      Icons.games  ),  Category(      6,      "Поездки",      "В категории пока нет мероприятий",      Icons.time_to_leave_outlined  ),  Category(      7,      "Другое",      "В категории пока нет мероприятий",      Icons.question_mark_outlined  ),];// MainPage не будет иметь состояния,// т.к. этот пример создан только для демонстрации// навигации в действииclass MainPage extends StatelessWidget {  // build как мы уже отметили, строит  // иерархию наших любимых виджетов  @override  Widget build(BuildContext context) {    return Scaffold(      appBar: AppBar(title: Text("Мои мероприятия")),      body: Padding(          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),          // создаем наш список          child: ListView(            children: cats.map<Widget>((category) {              return Material(                  color: Colors.black12,                  child: InkWell(                    splashColor: Colors.black12,                    //onTap: () {                     // Navigator.push(context, MaterialPageRoute(                         // builder: (context) => HomePage(category.id)                    //  ));                  //  },                    child: Container(                      padding: EdgeInsets.all(5),                      child: Row(                          children: <Widget>[                            Center(                                child: Text(                                    "    "  + category.name, // сделать нормальный отступ                                    style: Theme.of(context).textTheme.bodyLarge))                          ]                      ),                    ),                  )              );              // map возвращает Iterable объект, который необходимо              // преобразовать в список с помощью toList() функции            }).toList(),          )      ),    );  }}
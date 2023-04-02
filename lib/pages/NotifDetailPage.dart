import 'package:flutter/material.dart';
import 'notif_page.dart';

// также, как и NotifPage наша страница
// не будет иметь состояния
class NotifDetailPage extends StatelessWidget {
  // в качестве параметра мы будет получать id уведомления
  final int notifId;

  // конструктор NotifDetailPage принимает notifId,
  // который будет присвоен нашему ранее
  // объявленному полю
  NotifDetailPage(this.notifId);

  @override
  Widget build(BuildContext context) {
    // получаем уведомление по его id
    // обратите внимание: мы импортируем notifs
    // из файла notif_page.dart
    final notif = notifs[notifId];
    return Scaffold(
        appBar: AppBar(
          title: const Text("", style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),),
        body: Padding(
          // указываем отступ для контента
          padding: EdgeInsets.all(0),
          // Column размещает дочерние виджеты в виде колонки
          // crossAxisAlignment - выравнивание по ширине (колонка) или
          // по высоте (строка)
          // mainAxisAlignment работает наоборот
          // в данном случае мы растягиваем дочерние элементы
          // на всю ширину колонки
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  child: Image.asset(
                    notif.photo,
                    fit: BoxFit.cover,
                  )
              ),
              Flexible(child: Container(
                  padding: EdgeInsets.all(10),
                  // BoxDecoration имеет дополнительные свойства,
                  // посравнению с Container,
                  // такие как: gradient, borderRadius, border, shape
                  // и boxShadow
                  // здесь мы задаем радиус закругления левого и правого
                  // верхних углов
                  decoration: BoxDecoration(
                    // цвет Container'а мы указываем в BoxDecoration
                    color: Colors.amber,
                  ),
                  child: Text(
                    // указываем имя notif
                    notif.name,
                    style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.black),
                  )
              ),),
              Flexible(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        // указываем описание notif
                          notif.desc,
                          style: Theme.of(context).textTheme.bodyText1
                      )
                  )
              )
            ],
          ),
        )
    );
  }
}
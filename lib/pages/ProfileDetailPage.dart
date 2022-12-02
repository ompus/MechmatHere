import 'package:flutter/material.dart';

import 'profile_list_page.dart';

// Также, как и ProfileListPage наша страница
// не будет иметь состояния
class ProfileDetailPage extends StatelessWidget {
  // в качестве параметра мы будет получать id элемента списка страницы профиля
  final int profileId;

  // конструктор ProfileDetailPage принимает profileId,
  // который будет присвоен нашему ранее
  // объявленному полю
  ProfileDetailPage(this.profileId);

  @override
  Widget build(BuildContext context) {
    // получаем элемент списка страницы профиля по его id
    // обратите внимание: мы импортируем ProfScrElems
    // из файла profile_list_page.dart
    final prof = ProfScrElems[profileId];
    return Scaffold(
        appBar: AppBar(
          title: Text(prof.name)
        ),
        body: Padding(
          // указываем отступ для контента
          padding: EdgeInsets.all(15),
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
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                        // указываем описание prof
                          prof.desc,
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
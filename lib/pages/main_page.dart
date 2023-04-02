import 'package:flutter/material.dart';
import 'package:mechmat_tut/AddEvent.dart';

import '../CatDetailPage.dart';

class Category {
  final int id;
  final String name;
  final String desc;
  final IconData icon;

  Category(this.id, this.name, this.desc, this.icon);
}

final List<Category> cats = [
  Category(
      0,
      "Официальные",
      "В категории пока нет мероприятий",
       Icons.business_center_outlined
  ),
  Category(
      1,
      "Спорт",
      "В категории пока нет мероприятий",
      Icons.sports
  ),
  Category(
      2,
      "Учёба",
      "В категории пока нет мероприятий",
      Icons.import_contacts_outlined
  ),
  Category(
      3,
      "Настолки",
      "В категории пока нет мероприятий",
      Icons.casino_outlined
  ),
  Category(
      4,
      "Отдам в дар",
      "В категории пока нет мероприятий",
      Icons.redeem_outlined
  ),
  Category(
      5,
      "Игры",
      "В категории пока нет мероприятий",
      Icons.games
  ),
  Category(
      6,
      "Поездки",
      "В категории пока нет мероприятий",
      Icons.time_to_leave_outlined
  ),
  Category(
      7,
      "Другое",
      "В категории пока нет мероприятий",
      Icons.question_mark_outlined
  ),
];

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Главная",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),
          actions: [
          IconButton(
          icon: Icon(Icons.add), color: Colors.black,

              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AddEvent()
                  ));
              },)],
      ),

      // зададим небольшие отступы для списка
      body: Padding(
        // объект EdgeInsets хранит четыре важные double переменные:
        // left, top, right, bottom - отступ слева, сверху, справа и снизу
        // EdgeInsets.all(10) - задает одинаковый отступ со всех сторон
        // EdgeInsets.only(left: 10, right: 15) - задает отступ для
        // определенной стороны или сторон
        // EdgeInsets.symmetric - позволяет указать одинаковые
        // отступы по горизонтали (left и right) и по вертикали (top и bottom)
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          // создаем наш список
          child: ListView(
            // map принимает другую функцию, которая
            // будет выполняться над каждым элементом
            // списка и возвращать новый элемент (виджет Material).
            // Результатом map является новый список
            // с новыми элементами, в данном случае
            // это Material виджеты
            children: cats.map<Widget>((category) {
              // Material используется для того,
              // чтобы указать цвет элементу списка
              // и применить ripple эффект при нажатии на него
              return Material(
                color: Colors.black12,
                // InkWell позволяет отслеживать
                // различные события, например: нажатие
                child: InkWell(
                  // splashColor - цвет ripple эффекта
                  splashColor: Colors.black12,
                  // нажатие на элемент списка
                  onTap: () {
                    // Здесь мы используем сокращенную форму:
                    // Navigator.of(context).push(route)
                    // CatsDetailPage принимает category id,
                    // который мы и передали
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CatDetailPage(null, category.id)
                    ));
                  },
                  // далее указываем в качестве
                  // элемента Container с вложенным Text
                  // Container позволяет указать внутренние (padding)
                  // и внешние отступы (margin),
                  // а также тень, закругление углов,
                  // цвет и размеры вложенного виджета
                  child: Container(
                      padding: EdgeInsets.all(5),
                  child: Row(
                  children: <Widget>[
                    Icon(
                      category.icon,
                      size: 50,
                      color: Colors.grey,
                    ),
                    Center(
                        child: Text(
                        "    "  + category.name, // сделать нормальный отступ
                        style: Theme.of(context).textTheme.bodyLarge))
              ]
                ),
              ),
                )
              );
              // map возвращает Iterable объект, который необходимо
              // преобразовать в список с помощью toList() функции
            }).toList(),
          )
      ),
    );
  }
}
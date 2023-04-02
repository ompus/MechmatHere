import 'package:flutter/material.dart';
import 'package:mechmat_tut/pages/NotifDetailPage.dart';

// класс уведомления, который будет хранить имя, фото, описание, а также id
class Notif {
  final int id;
  final String name;
  final String photo;
  final String desc;

  Notif(this.id, this.name, this.photo, this.desc);
}

// создаем список уведомлений
// final указывает на то, что мы больше
// никогда не сможем присвоить имени notifs
// другой список уведомлений
final List<Notif> notifs = [
  Notif(
      0,
      "В го поиграем?",
      "assets/images/Го.jpg",
      "Ищем людей для игры в го. Ещё двое надо. Пишите в ВК, там быстрее отвечаю"
  ),
  Notif(
      1,
      "Помогите с матлогом. 2 курс. ИП",
      "assets/images/Матлог.jpg",
      "Была в отъезде, пропустила тему <<Исчисление предикатов>>. Контрольная через неделю, кто сможет вкратце обсъяснить в чём суть? С меня шоколадка =)"
  ),
  Notif(
      2,
      "В Москву на НГ?",
      "assets/images/Москва.jpg",
      "Ищу компанию, на машинке в Москву. Выезжаем 27 декабря. Вместе дешевле)"

  ),
  Notif(
      3,
      "Отдам билет на Гарика Сукачёва",
      "assets/images/Сукачёв.jpg",
      "Хотел сгонять, расслабиться 4 декабря. А Гарик заболел, потом времени сходить не будет. Отдам билет в хорошие руки"
  ),
];

// NotifPage не будет иметь состояния,
// т.к. этот пример создан только для демонстрации
// навигации в действии
class NotifPage extends StatelessWidget {

  // build как мы уже отметили, строит
  // иерархию наших любимых виджетов
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Уведомления",
          style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),),
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
            children: notifs.map<Widget>((notif) {
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
                    // NotifDetailPage принимает notif id,
                    // который мы и передали
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => NotifDetailPage(notif.id)
                    ));
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
                          notif.name,
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
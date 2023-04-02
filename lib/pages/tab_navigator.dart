import 'package:flutter/material.dart';
import 'package:mechmat_tut/pages/main_page.dart';
import 'package:mechmat_tut/pages/notif_page.dart';
import '../NotifEventsPage.dart';
import '../models/tab.dart';

import 'profile_list_page.dart';

class TabNavigator extends StatelessWidget {
  // TabNavigator принимает:
  // navigatorKey - уникальный ключ для NavigatorState
  // tabItem - текущий пункт меню
  TabNavigator({required this.navigatorKey, required this.tabItem});

  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;

  @override
  Widget build(BuildContext context) {
    // здесь мы присваиваем navigatorKey
    // только, что созданному Navigator'у
    // navigatorKey, как уже было отмечено является ключом,
    // по которому мы получаем доступ к состоянию Navigator'a
    return Navigator(
      key: navigatorKey,
      // Navigator имеет параметр initialRoute,
      // который указывает начальную страницу и является
      // всего лишь строкой.
      // Отметим, что по умолчанию initialRoute равен /
      // initialRoute: "/",

      // Navigator может сам построить наши страницы или
      // мы можем переопределить метод onGenerateRoute
      onGenerateRoute: (routeSettings) {
        // сначала определяем текущую страницу
        Widget currentPage;
        if (tabItem == TabItem.HOME) {
          currentPage = MainPage();
        } else if (tabItem == TabItem.NOTIFS) {
          currentPage = NotifEventPage();
        } else {
          currentPage = ProfileListPage();
        }
        // строим Route (страница или экран)
        return MaterialPageRoute(builder: (context) => currentPage,);
      },
    );
  }

}
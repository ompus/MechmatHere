import 'package:flutter/material.dart';
import '../models/tab.dart';

// создаем три пункта меню
// const обозначает, что tabs является
// постоянной ссылкой и мы больше
// ничего не сможем ей присвоить,
// иначе говоря, она определена во время компиляции
const Map<TabItem, MyTab> tabs = {
  TabItem.HOME : const MyTab(name: "Домой", color: Colors.amber, icon: Icons.home),
  TabItem.NOTIFS : const MyTab(name: "Уведомления", color: Colors.amber, icon: Icons.notifications_none_outlined),
  TabItem.PROFILE : const MyTab(name: "Профиль", color: Colors.amber, icon: Icons.account_circle_outlined)
};

class MyBottomNavigation extends StatelessWidget {
  // MyBottomNavigation принимает функцию onSelectTab
  // и текущую выбранную вкладку
  MyBottomNavigation({required this.currentTab, required this.onSelectTab});

  final TabItem currentTab;
  // ValueChanged<TabItem> - функциональный тип,
  // то есть onSelectTab является ссылкой на функцию,
  // которая принимает TabItem объект
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    // Используем встроенный виджет BottomNavigationBar для
    // реализации нижнего меню
    return BottomNavigationBar(
        selectedItemColor: _colorTabMatching(currentTab),
        selectedFontSize: 13,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab.index,
        // пункты меню
        items: [
          _buildItem(TabItem.HOME),
          _buildItem(TabItem.NOTIFS),
          _buildItem(TabItem.PROFILE),
        ],
        // обработка нажатия на пункт меню
        // здесь мы делаем вызов функции onSelectTab,
        // которую мы получили через конструктор
        onTap: (index) => onSelectTab(
            TabItem.values[index]
        )
    );
  }

  // построение пункта меню
  BottomNavigationBarItem _buildItem(TabItem item) {
    return BottomNavigationBarItem(
      // указываем иконку
      icon: Icon(
        _iconTabMatching(item),
        color: _colorTabMatching(item),
      ),
      // указываем метку или название
      label: tabs[item]?.name,
    );
  }

  // получаем иконку элемента
  IconData _iconTabMatching(TabItem item) => tabs[item]!.icon;

  // получаем цвет элемента
  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? tabs[item]!.color : Colors.grey;
  }
}

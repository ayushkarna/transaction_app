import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 60,
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      indicatorColor: Colors.blue.shade900,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_sharp),
          selectedIcon: Icon(
            Icons.notifications_sharp,
            color: Colors.white,
          ),
          label: 'Transaction',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:transaction_app/screens/home_screen.dart';
import 'package:transaction_app/screens/transaction_screen.dart';
import 'package:transaction_app/widgets/navbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List pageViewList = const [
    HomeScreen(),
    TransactionScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (int value) {
            setState(() {
              currentIndex = value;
            });
          }),
      body: pageViewList[currentIndex],
    );
  }
}

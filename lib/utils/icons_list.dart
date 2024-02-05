import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcons {
  final List<Map<String, dynamic>> homeExpenseCategories = [
    {
      "name": "Gas Filling",
      "icon": FontAwesomeIcons.gasPump,
    },
    {
      "name": "Grocery",
      "icon": FontAwesomeIcons.cartShopping,
    },
    {
      "name": "Milk",
      "icon": FontAwesomeIcons.mugHot,
    },
    {
      "name": "Internet",
      "icon": FontAwesomeIcons.wifi,
    },
    {
      "name": "Electricity",
      "icon": FontAwesomeIcons.bolt,
    },
    {
      "name": "Water",
      "icon": FontAwesomeIcons.water,
    },
    {
      "name": "Dining Out",
      "icon": FontAwesomeIcons.utensils,
    },
    {
      "name": "Phone Bill",
      "icon": FontAwesomeIcons.phone,
    },
    {
      "name": "Entertainment",
      "icon": FontAwesomeIcons.film,
    },
    {
      "name": "Health Care",
      "icon": FontAwesomeIcons.suitcaseMedical,
    },
    {
      "name": "Transportation",
      "icon": FontAwesomeIcons.bus,
    },
    {
      "name": "Clothing",
      "icon": FontAwesomeIcons.shirt,
    },
    {
      "name": "Insurance",
      "icon": FontAwesomeIcons.shieldHalved,
    },
    {
      "name": "Education",
      "icon": FontAwesomeIcons.graduationCap,
    },
    {
      "name": "Others",
      "icon": FontAwesomeIcons.cartPlus,
    },
  ];

  IconData getExpenseCategoryIcons(String categoryName) {
    final category = homeExpenseCategories.firstWhere(
        (category) => category['name'] == categoryName,
        orElse: () => {"icon": FontAwesomeIcons.cartShopping});
    return category['icon'];
  }
}

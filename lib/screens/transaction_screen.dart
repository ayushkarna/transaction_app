import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/widgets/category_list.dart';
import 'package:transaction_app/widgets/tab_bar_view.dart';
import 'package:transaction_app/widgets/timeline_month.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  var category = "ALL";
  var monthYear = '';
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    setState(() {
      monthYear = DateFormat('MMM y').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Transactions")),
      body: Column(
        children: [
          TimeLineMonth(
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  monthYear = value;
                });
              }
            },
          ),
          CategoryList(onChanged: (String? value) {
            if (value != null) {
              setState(() {
                category = value;
              });
            }
          }),
          TypeTabBar(
            category: category,
            monthYear: monthYear,
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/services/auth_service.dart';
import 'package:transaction_app/utils/app_validator.dart';
import 'package:transaction_app/widgets/category_dropdown.dart';
import 'package:uuid/uuid.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var type = 'credit';
  var category = "Others";
  bool isLoader = false;
  var appValidator = AppValidator();
  var authService = AuthService();
  var amountEditingController = TextEditingController();
  var titleEditController = TextEditingController();
  var uid = Uuid();
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      final user = FirebaseAuth.instance.currentUser;
      int timestamp = DateTime.now().microsecondsSinceEpoch;
      var amount = int.parse(amountEditingController.text);
      DateTime date = DateTime.now();

      var id = uid.v4();
      String monthyear = DateFormat('MMM y').format(date);

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      int remainingAmount = userDoc['remainingAmount'];
      int totalCredit = userDoc['totalCredit'];
      int totalDebit = userDoc['totalDebit'];

      if (type == 'credit') {
        remainingAmount += amount;
        totalCredit += amount;
      } else {
        remainingAmount -= amount;
        totalDebit += amount;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        "remainingAmount": remainingAmount,
        "totalCredit": totalCredit,
        "totalDebit": totalDebit,
        "updatedAt": timestamp,
      });
      var data = {
        "id": id,
        "title": titleEditController.text,
        "amount": amount,
        "type": type,
        "timestamp": timestamp,
        "totalCredit": totalCredit,
        "totalDebit": totalDebit,
        "remainingAmount": remainingAmount,
        "monthyear": monthyear,
        "category": category,
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('transactions')
          .doc(id)
          .set(data);
      Navigator.pop(context);
      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: titleEditController,
                validator: appValidator.isEmptyCheck,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: amountEditingController,
                validator: appValidator.isEmptyCheck,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              CategoryDropDown(
                  cattype: category,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        category = value;
                      });
                    }
                  }),
              DropdownButtonFormField(
                  value: 'credit',
                  items: const [
                    DropdownMenuItem(
                      value: 'credit',
                      child: Text('Credit'),
                    ),
                    DropdownMenuItem(
                      value: 'debit',
                      child: Text('Debit'),
                    )
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        type = value;
                      });
                    }
                  }),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (isLoader == false) {
                      _submitForm();
                    }
                  },
                  child: isLoader
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text("Add Transaction")),
            ],
          )),
    );
  }
}

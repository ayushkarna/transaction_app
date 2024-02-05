import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/screens/login_screen.dart';
import 'package:transaction_app/widgets/add_transaction_form.dart';
import 'package:transaction_app/widgets/hero_card.dart';
import 'package:transaction_app/widgets/transactions_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;
  logout() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginView()));
    setState(() {
      isLogoutLoading = false;
    });
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;

  _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: AddTransactionForm(),
          );
        });
  }

  late Future<String> username;

  @override
  void initState() {
    super.initState();
    username = getUsernameFromFirestore(userId);
  }

  Future<String> getUsernameFromFirestore(String userId) async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;

        if (userData != null && userData.containsKey('username')) {
          return userData['username'];
        } else {
          return 'Username Field Missing';
        }
      } else {
        return 'User Document Not Found';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  String capitalizeFirstLetter(String? input) {
    if (input == null || input.isEmpty) {
      return '';
    }
    return '${input[0].toUpperCase()}${input.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          _dialogBuilder(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: isLogoutLoading
                  ? const CircularProgressIndicator()
                  : const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    )),
        ],
        title: FutureBuilder<String>(
          future: username,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                'Hello,',
                style: TextStyle(
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final String greeting =
                  'Hello, ${capitalizeFirstLetter(snapshot.data) ?? 'Username'}';
              return Text(
                greeting,
                style: const TextStyle(color: Colors.white),
              );
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroCard(
              userId: userId,
            ),
            const TransactionsCard(),
          ],
        ),
      ),
    );
  }
}

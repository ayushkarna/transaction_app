import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersStream =
        FirebaseFirestore.instance.collection('users').doc(userId).snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        var data = snapshot.data!.data() as Map<String, dynamic>;
        return Cards(
          data: data,
        );
      },
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({
    super.key,
    required this.data,
  });
  final Map data;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Balance ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "रु ${data['remainingAmount']}",
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 10,
              left: 10,
              right: 10,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: Row(
              children: [
                CardOne(
                  amount: "${data['totalCredit']}",
                  color: Colors.green,
                  heading: "Credit",
                ),
                const SizedBox(
                  width: 10,
                ),
                CardOne(
                  amount: "${data['totalDebit']}",
                  color: Colors.red,
                  heading: "Debit",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardOne extends StatelessWidget {
  final Color color;
  final String amount;
  final String heading;
  const CardOne({
    super.key,
    required this.color,
    required this.heading,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: TextStyle(
                      color: color,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "रु $amount",
                    style: TextStyle(
                      color: color,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  heading == "Credit"
                      ? Icons.arrow_upward_outlined
                      : Icons.arrow_downward_outlined,
                  color: color,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

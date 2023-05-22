import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Create'),
          centerTitle: true,
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              _create();
            },
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Create',
                    style: TextStyle(color: Colors.white),
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _create() async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final docRef = userCollection.doc('user-id');

    await docRef.set({
      "username": "Jhon",
      "age": 55
    });
  }
}
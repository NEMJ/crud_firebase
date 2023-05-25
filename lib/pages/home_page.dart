import 'package:crud_firebase/data/models/remote_data_source/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Create'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'username',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'age',
                ),
              ),
              const SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  FirestoreHelper.create(
                    UserModel(
                      username: _usernameController.text,
                      age: _ageController.text
                    ));
                  // _create();
                },
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
            ],
          ),
        ),
      ),
    );
  }

  // Future _create() async {
  //   final userCollection = FirebaseFirestore.instance.collection('users');
  //   final docRef = userCollection.doc();

  //   await docRef.set({
  //     "username": _usernameController.text,
  //     "age": _ageController.text
  //   });
  // }
}
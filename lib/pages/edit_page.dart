import 'package:flutter/material.dart';
import '../data/models/remote_data_source/firestore_helper.dart';
import '../data/models/user_model.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    required this.user,
    super.key,
  });

  final UserModel user;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _usernameController;
  late TextEditingController _ageController;

  @override
  void initState() {
    _usernameController = TextEditingController(text: widget.user.username);
    _ageController = TextEditingController(text: widget.user.age);
    super.initState();
  }

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
          centerTitle: true,
          title: const Text('Edit Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "username",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "age",
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                   FirestoreHelper.update(
                    UserModel(
                      id: widget.user.id,
                      username: _usernameController.text,
                      age: _ageController.text,
                    ),
                   ).then((value) => Navigator.pop(context));
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
                        Icons.upload,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ]
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
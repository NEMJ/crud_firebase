import 'package:flutter/material.dart';
import '../data/models/remote_data_source/firestore_helper.dart';
import '../data/models/user_model.dart';
import '../pages/edit_page.dart';

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
              const SizedBox(height: 10),
              StreamBuilder<List<UserModel>>(
                stream: FirestoreHelper.read(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if(snapshot.hasError) {
                    return const Center(child: Text('some error occured'),);
                  }
                  if(snapshot.hasData) {
                    final userData = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: userData!.length,
                        itemBuilder: (context, index) {
                          final singleUser = userData[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              onLongPress: () {
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete'),
                                    content: const Text('are you sure you want to delete'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          FirestoreHelper.delete(singleUser).then((value) {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ]
                                  );
                                });
                              },
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.deepPurple,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              title: Text("${singleUser.username}"),
                              subtitle: Text("${singleUser.age}"),
                              trailing: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) => EditPage(
                                        user: UserModel(
                                          id: singleUser.id,
                                          username: singleUser.username,
                                          age: singleUser.age,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.edit),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
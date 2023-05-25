import 'package:cloud_firestore/cloud_firestore.dart';
import '../user_model.dart';

class FirestoreHelper {

  static Future create(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final docRef = userCollection.doc();

    final newUser = UserModel(
      username: user.username,
      age: user.age,
    ).toJson();

    try {
      await docRef.set(newUser);
    } catch(e) {
      print("some error occurred $e");
    }

    
  }
}
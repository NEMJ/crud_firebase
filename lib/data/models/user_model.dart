import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.id,
    this.username,
    this.age
  });

  final String? id;
  final String? username;
  final String? age;

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      id: snapshot['id'],
      username: snapshot['username'],
      age: snapshot['age'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "age": age,
  };
}
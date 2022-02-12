import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class DatabaseService {
  static DatabaseService instance = DatabaseService(uid: '');

  final String uid;
  DatabaseService({required this.uid});

  //UserFromFirebase currentUser;

  //collection reference
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String email, String name, String fuelCost, String totalCalories, String totalDrive) async {
    return await usersRef.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'fuelCost': fuelCost,
      'totalCalories': totalCalories,
      'totalDrive': totalDrive,
    });
  }
}
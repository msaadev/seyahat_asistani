import 'package:cloud_firestore/cloud_firestore.dart';

class UserFromFirebase {
  final String uid;

  UserFromFirebase({required this.uid});
}

class UserData {
  final String uid;
  final String email;
  final String name;
  final String fuelCost;
  final String totalCalories;
  final String totalDrive;
  final String totalWalk;

  UserData(
      {required this.uid,
      required this.email,
      required this.name,
      required this.fuelCost,
      required this.totalCalories,
      required this.totalDrive,
      required this.totalWalk});

  factory UserData.fromDocument(DocumentSnapshot doc) {
    return UserData(
      uid: doc['uid'],
      email: doc['email'],
      name: doc['name'],
      fuelCost: doc['fuelCost'],
      totalCalories: doc['totalCalories'],
      totalDrive: doc['totalDrive'],
      totalWalk: doc['totalWalk'],
    );
  }
}

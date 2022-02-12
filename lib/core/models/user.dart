import 'package:cloud_firestore/cloud_firestore.dart';

class UserFromFirebase {
  final String uid;

  UserFromFirebase({required this.uid});
}

class UserData {
  final String uid;
  final String email;
  final String name;
  final String surname;
  final String fuelCost;

  UserData(
      {required this.uid,
      required this.email,
      required this.name,
      required this.surname,
      required this.fuelCost});

  factory UserData.fromDocument(DocumentSnapshot doc) {
    return UserData(
      uid: doc['uid'],
      email: doc['email'],
      name: doc['name'],
      surname: doc['surname'],
      fuelCost: doc['fuelcost']
    );
  }
}

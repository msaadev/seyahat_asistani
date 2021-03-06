import 'package:cloud_firestore/cloud_firestore.dart';
import '../init/cache/cache_manager.dart';
import '../models/travel_model.dart';
import 'package:uuid/uuid.dart';

import '../models/user.dart';

class DatabaseService {
  static DatabaseService instance = DatabaseService(uid: '');

  final String uid;
  DatabaseService({required this.uid});

  //UserFromFirebase currentUser;

  //collection reference
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference pinsRef =
      FirebaseFirestore.instance.collection('pins');

  Future updateUserData(String email, String name, String fuelCost,
      String totalCalories, String totalDrive, String totalWalk) async {
    return await usersRef.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'fuelCost': fuelCost,
      'totalCalories': totalCalories,
      'totalDrive': totalDrive,
      'totalWalk': totalWalk,
    });
  }

  Future updateUserDataOnTour(TravelModel travel, isCar) async {
    var user = CacheManager.instance.getUser;
    if (user != null) {
      var newFuel =
          (double.tryParse(user.fuelCost) ?? 0) + (!isCar ? 0 : travel.fuel);
      var newCalorie = (double.tryParse(user.totalCalories) ?? 0) +
          (!isCar ? 0 : travel.calories);
      var newWalk = (double.tryParse(user.totalWalk) ?? 0) +
          (!isCar ? travel.distance : 0);
      var newDrive = (double.tryParse(user.totalDrive) ?? 0) +
          (!isCar ? 0 : travel.distance);
      var newUser = UserData(
          uid: uid,
          email: user.email,
          name: user.name,
          fuelCost: newFuel.toStringAsFixed(2),
          totalCalories: newCalorie.toStringAsFixed(2),
          totalDrive: newDrive.toStringAsFixed(2),
          totalWalk: newWalk.toStringAsFixed(2));

      await usersRef.doc(uid).set({
        'uid': uid,
        'email': user.email,
        'name': user.name,
        'fuelCost': user.fuelCost,
        'totalCalories': newCalorie,
        'totalDrive': newDrive,
        'totalWalk': newWalk,
      });
      CacheManager.instance.setUserData(newUser);
      return;
    }
  }

  Future createPinInFirestore(
    String description,
    double latitude,
    double longitude,
    //DocumentSnapshot doc
  ) async {
    String pinId = const Uuid().v4();
    return await pinsRef.doc(pinId).set({
      "pinId": pinId,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
    });
  }

  getUserData(String userUid) async {
    DocumentSnapshot documentSnaphot = await usersRef.doc(userUid).get();

    return documentSnaphot;
  }
}

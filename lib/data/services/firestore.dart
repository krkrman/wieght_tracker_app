import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wieght_tracker_app/data/models/weight_model.dart';

class Firestore {
  static Future<void> storeWeight(WeightModel weightModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(weightModel.dateTime.toString())
          .set(weightModel.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<List<WeightModel>> getListOfWeights() async {
    List<WeightModel> weights = [];
    try {
      FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .orderBy('dateTime')
          .snapshots()
          .listen((event) {
        weights.clear();
        for (var doc in event.docs) {
          debugPrint(doc.data().toString());
          weights.add(WeightModel.fromMap(doc.data()));
          debugPrint(weights.toString());
        }
      });
    } catch (e) {
      debugPrint('problem happened');
    }
    return weights;
  }

  static Future<void> updateWeight(WeightModel weightModel) async {
    FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc(weightModel.dateTime.toString())
        .update({'weigth': weightModel.weight})
        .then((value) => debugPrint("User Updated"))
        .catchError((error) => debugPrint("Failed to update user: $error"));
  }

  static Future<void> deleteWeight(WeightModel weightModel) async {
    await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc(weightModel.dateTime.toString())
        .delete()
        .then((value) => debugPrint("User deleted"))
        .catchError((error) => debugPrint("Failed to update user: $error"));
  }

}

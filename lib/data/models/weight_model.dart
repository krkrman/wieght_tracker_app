import 'package:cloud_firestore/cloud_firestore.dart';

class WeightModel {
  String weight;
  DateTime dateTime;

  WeightModel({
    required this.weight,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'dateTime': dateTime,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      weight: map['weight'] as String,
      dateTime: map['dateTime'].toDate(),
    );
  }
}

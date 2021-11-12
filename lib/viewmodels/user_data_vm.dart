import 'package:acme_fit/models/health_tracker_data_model.dart';
import 'package:flutter/cupertino.dart';

class UserDataVM with ChangeNotifier {
  String? userName, bloodGroup, userId;
  double? height;
  //TrackerDataModel? lastTrackedData;
  int? age;
  DateTime? joinedDate;

  updateUserDataVM({
    required String userName,
    required String bloodGroup,
    required double height,
    required String userId,
    required int age,
    required DateTime joinedDate,
    // required lastTrackedData
  }) {
    this.userName = userName;
    this.age = age;
    this.bloodGroup = bloodGroup;
    this.height = height;
    this.joinedDate = joinedDate;
    this.userId = userId;
    notifyListeners();
  }
}

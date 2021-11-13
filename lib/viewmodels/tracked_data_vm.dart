// import 'package:acme_fit/models/blood_pressure_model.dart';
// import 'package:acme_fit/models/health_tracker_data_model.dart';
// import 'package:acme_fit/screens/details_screen/details_screen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';

// class TrackedDataVM with ChangeNotifier {
//   List<TrackerDataModel> trackedDataList = [];
//   List<double> weightDataList = [];
//   List<int> excerciseDataList = [];
//   List<BloodPressureModel> bpDataList = [];

//   updateChangesToListners() {
//     notifyListeners();
//   }

//   setTrackerDataModelList(List<TrackerDataModel> list) {
//     trackedDataList = list;
//     for (TrackerDataModel item in list) {
//       if (item.currentWeight == null) {
//         weightDataList.add(item.currentWeight!);
//       }
//       if (item.bloodPressureModel == null) {
//         bpDataList.add(item.bloodPressureModel!);
//       }
//       if (item.exerciseTime == null) {
//         excerciseDataList.add(item.exerciseTime!);
//       }
//     }
//   }

//   setBloodPressureDataList(
//       List<BloodPressureModel> list, TrackerDataType trackedDataType) {
//     bpDataList = list;
//     updateChangesToListners();
//   }

//   setExcerciseDataList(List<int> list, TrackerDataType trackedDataType) {
//     excerciseDataList = list;
//     updateChangesToListners();
//   }

//   setWeightDataList(List<double> list, TrackerDataType trackedDataType) {
//     weightDataList = list;
//     updateChangesToListners();
//   }
// }

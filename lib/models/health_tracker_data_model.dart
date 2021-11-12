import 'package:acme_fit/models/blood_pressure_model.dart';

class TrackerDataModel {
  double? currentWeight;
  BloodPressureModel? bloodPressureModel;
  int? exerciseTime;
  String? documentId;
  DateTime? submittedTime;
  TrackerDataModel(
      {this.bloodPressureModel, this.currentWeight, this.exerciseTime});
  TrackerDataModel.toJson(Map<String, dynamic> map, String id) {
    exerciseTime = map["exerciseTime"];
    bloodPressureModel = BloodPressureModel.fromJson(map);
    currentWeight = map["currentWeight"];
    documentId = id;
    submittedTime = map["SystolicValue"];
  }
  Map<String, dynamic> toJson() {
    return {
      "currentWeight": currentWeight,
      "exerciseTime": exerciseTime,
      "bloodPressure": {
        "currentSystolicValue": bloodPressureModel?.currentSystolicValue,
        "currentDiastolicValue": bloodPressureModel?.currentDiastolicValue
      },
      "submittedTime": submittedTime,
    };
  }
}

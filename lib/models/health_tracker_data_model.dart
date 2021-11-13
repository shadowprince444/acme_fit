import 'package:acme_fit/models/blood_pressure_model.dart';

class TrackerDataModel {
  double? currentWeight;
  BloodPressureModel? bloodPressureModel;
  int? exerciseTime;
  String? documentId;
  DateTime? submittedTime;
  TrackerDataModel(
      {this.bloodPressureModel,
      this.currentWeight,
      this.exerciseTime,
      this.submittedTime});

  TrackerDataModel.fromJson(Map<String, dynamic> map, String id) {
    exerciseTime = map["exerciseTime"];
    bloodPressureModel = BloodPressureModel.fromJson(map["bloodPressure"]);
    currentWeight = map["currentWeight"]?.toDouble() ?? 0.0;
    documentId = id;
    submittedTime = map["submittedTime"]?.toDate();
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

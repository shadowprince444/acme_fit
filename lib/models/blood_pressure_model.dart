class BloodPressureModel {
  int? currentSystolicValue, currentDiastolicValue;

  BloodPressureModel({
    this.currentSystolicValue,
    this.currentDiastolicValue,
  });
  BloodPressureModel.fromJson(Map<String, dynamic> map) {
    currentSystolicValue = map["currentSystolicValue"];

    currentDiastolicValue = map["currentDiastolicValue"];
  }
  Map<String, dynamic> toMap() {
    return {
      "currentSystolicValue": currentSystolicValue,
      "currentDiastolicValue": currentDiastolicValue
    };
  }
}

class UserCollectionDataModel {
  String? name, bloodGroup;
  int? height, age, lastExcerciseTime;
  double? averageSystolicValue,
      averageExcerciseTime,
      averageDiastolicValue,
      averageWeight,
      lastSystolicValue,
      lastDiastolicValue,
      lastWeight;
  UserCollectionDataModel(
      {required this.name,
      required this.bloodGroup,
      required this.age,
      required this.averageExcerciseTime,
      required this.lastExcerciseTime,
      required this.averageSystolicValue,
      required this.averageDiastolicValue,
      required this.averageWeight,
      required this.lastSystolicValue,
      required this.lastDiastolicValue,
      required this.lastWeight,
      required this.height});
  UserCollectionDataModel.fromJson(Map<String, dynamic> map) {
    name = map["name"] ?? "N/A";
    bloodGroup = map["bloodGroup"] ?? "N/A";
    age = map["age"] ?? 0;
    averageExcerciseTime =
        (map["totalExercise"] ?? 0) / map["numberOfRecords"] ?? 1.0;

    averageSystolicValue =
        ((map["totalSystolicValue"] ?? 0) / map["numberOfRecords"] ?? 1.0);
    averageDiastolicValue =
        (map["totalDiastolicValue"] ?? 0) / map["numberOfRecords"] ?? 1.0;
    averageWeight = (map["totalWeight"] ?? 0) / map["numberOfRecords"] ?? 1.0;

    lastExcerciseTime = map["lastExercise"] ?? 0;
    lastSystolicValue = map["lastSystolicValue"]?.toDouble() ?? 0.0;
    lastDiastolicValue = map["lastDiastolicValue"]?.toDouble() ?? 0.0;
    lastWeight = map["lastWeight"]?.toDouble() ?? 0.0;
    height = map["height"] ?? 0;
  }
}

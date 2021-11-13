import 'package:acme_fit/models/health_tracker_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrackerDataRepo {
  static CollectionReference trackerDataCollection(String userId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("trackedData");
  }

  static addData(String userId, TrackerDataModel trackerDataModel) async {
    try {
      await trackerDataCollection(userId)
          .add(trackerDataModel.toJson())
          .then((value) async {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .update({
          "totalExercise": FieldValue.increment(trackerDataModel.exerciseTime!),
          "totalWeight": FieldValue.increment(trackerDataModel.currentWeight!),
          "totalDiastolicValue": FieldValue.increment(
              trackerDataModel.bloodPressureModel!.currentDiastolicValue!),
          "totalSystolicValue": FieldValue.increment(
            trackerDataModel.bloodPressureModel!.currentSystolicValue!,
          ),
          "numberOfRecords": FieldValue.increment(1),
          "lastExercise": trackerDataModel.exerciseTime!,
          "lastWeight": trackerDataModel.currentWeight!,
          "lastDiastolicValue":
              trackerDataModel.bloodPressureModel!.currentDiastolicValue!,
          "lastSystolicValue":
              trackerDataModel.bloodPressureModel!.currentSystolicValue!,
        });
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future editTrackedData(
      TrackerDataModel trackerDataModel, String userId) async {
    try {
      await trackerDataCollection(userId)
          .doc(trackerDataModel.documentId)
          .update(trackerDataModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  static Stream<List<TrackerDataModel>> getTrackedData(String userId) {
    return trackerDataCollection(userId)
        .orderBy("submittedTime", descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .map((e) =>
              TrackerDataModel.fromJson(e.data() as Map<String, dynamic>, e.id))
          .toList();
    });
  }
}

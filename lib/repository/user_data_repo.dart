import 'package:acme_fit/models/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataRepo {
  static final userCollection = FirebaseFirestore.instance.collection("users");
  // static getUserData(BuildContext context) async {
  //   String userId =
  //       Provider.of<AuthenticationVM>(context, listen: false).userId!;
  //   userCollection.doc(userId).get().then((value) async {
  //     if (value.exists) {
  //       // await userCollection.doc(userId).
  //       Map<String, dynamic> map = value.data()!;
  //       Provider.of<UserDataVM>(context, listen: false).updateUserDataVM(
  //           userName: map["name"],
  //           bloodGroup: map["bloodGroup"],
  //           height: map["height"]?.toDouble() ?? 0.0,
  //           userId: userId,
  //           age: map["age"],
  //           joinedDate: map["joinedDate"].toDate());
  //     }
  //   });
  // }

  static Stream<UserCollectionDataModel> getUserCollectionStream(
      String userId) {
    return userCollection
        .doc(userId)
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      return UserCollectionDataModel.fromJson(documentSnapshot.data() ?? {});
    });
  }
}

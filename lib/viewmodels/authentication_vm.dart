// ignore_for_file: avoid_print

import 'package:acme_fit/models/user_cred_model.dart';
import 'package:flutter/material.dart';

class AuthenticationVM with ChangeNotifier {
  UserCredModel? _userCredModel;

  store(String? userId, String? jwtToken, String? userName, String? email,
      String? imageUrl) {
    _userCredModel = UserCredModel(
        imageUrl: imageUrl, userId: userId, jwtToken: jwtToken, email: email);

    print("----------------$userId-----------------");
    notifyListeners();
  }

  String? get jwtToken => _userCredModel!.jwtToken;
  String? get userId => _userCredModel?.userId!;
  String get email => _userCredModel!.email!;

  String? get imageUrl => _userCredModel?.imageUrl;
}

import 'package:firebase_auth/firebase_auth.dart';

class LogInRepository {
  static Future<String?> logIn(String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        return null;
      });
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }
}

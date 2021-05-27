import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  ////////General Functions//////
  Future<String> getUid() async {
    return FirebaseAuth.instance.currentUser.uid ?? '';
  }
}

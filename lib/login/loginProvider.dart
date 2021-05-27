import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/repositories/loginRepository.dart';

class LoginProvider extends ChangeNotifier {
  LoginRepository repo = LoginRepository();
  String test = 'test';
  List<DropdownMenuItem<String>> sections = [];
  bool sectionLoading = true;
  String sectionSelected;
  bool userRegSuccess = false;
  String authKey;
  bool authenticated = false;
  bool keyFetching = true;
  String regError = '';
  bool userRegistering = false;
  String loginError = '';
  bool loginSuccess = false;
  bool loading = false;

  void checkAuth(String key) {
    if (key == authKey) {
      authenticated = true;
      notifyListeners();
    }
  }

  Future<void> login(String tokenNumber) async {
    loading = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: '$tokenNumber@mahindra.com', password: 'mahindra');
      //Map<String, dynamic> details =
      //await repo.getName(userCredential.user.uid);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('name', details['name']);
      // prefs.setString('department', details['department']);
      // print(details.toString());
      print('Success');
      loginSuccess = true;
      loading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        loginError = ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        loginError = ('Wrong password provided for that user.');
      }
      loading = false;
      notifyListeners();
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/dashboard.dart';
import 'package:mahindra_chakkan_analysis/login/loginBase.dart';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  bool check;
  bool loading = true;
  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    User user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        check = true;
        loading = false;
      });
    } else {
      setState(() {
        check = false;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: Image.asset('assets/mahindra-logo.png'),
            )
          : (check ? DashBoard() : LoginBase()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/login/loginForm.dart';
import 'package:mahindra_chakkan_analysis/login/loginProvider.dart';
import 'package:provider/provider.dart';

class LoginBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: LoginScreen(),
    );
  }
}

import 'package:flutter/material.dart';

Widget loading(String type) {
  switch (type) {
    case 'class':
      {
        return Loading();
      }
      break;
    case 'widget':
      {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      break;
    default:
      {
        return Loading();
      }
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

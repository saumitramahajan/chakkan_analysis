import 'package:flutter/material.dart';

Widget wrong(String type) {
  switch (type) {
    case 'class':
      {
        return Wrong();
      }
      break;
    case 'widget':
      {
        return Container(
          child: Center(
            child: Text('Something Went Wrong. Please Try Again!'),
          ),
        );
      }
      break;
    default:
      {
        return Wrong();
      }
  }
}

class Wrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text('Something Went Wrong. Please Try Again!'),
        ),
      ),
    );
  }
}

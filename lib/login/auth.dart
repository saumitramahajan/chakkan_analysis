import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/login/loginProvider.dart';
import 'package:mahindra_chakkan_analysis/utils/loading.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    TextEditingController key = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          title: Text(
            'Authenticate User',
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.close,
            ),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
        body: provider.keyFetching
            ? Loading()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Please ask admin to enter authentication key:',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: key,
                      decoration:
                          InputDecoration(labelText: 'Authentication Key'),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          provider.checkAuth(key.text);
                          if (provider.authenticated) {
                            Navigator.of(context).pop();
                          } else {
                            final snackBar = SnackBar(
                                content: Text('Authentication Key Incorrect!'));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            print('not correct');
                            key.text = '';
                          }
                        },
                        child: Text('Submit'))
                  ],
                ),
              ));
  }
}

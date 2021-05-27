import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mahindra_chakkan_analysis/dashboard.dart';
import 'package:mahindra_chakkan_analysis/login/loginProvider.dart';
import 'package:mahindra_chakkan_analysis/utils/loading.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    timeDilation = 1.2;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    void login() async {
      FocusScope.of(context).requestFocus(FocusNode());
      if (_email.isNotEmpty) {
        await provider.login(_email);
        if (provider.loginSuccess) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => DashBoard(),
          ));
        } else {
          final snackBar = SnackBar(content: Text(provider.loginError));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar =
            SnackBar(content: Text('Please enter a Token Number!'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: null,
      body: provider.loading
          ? Loading()
          : SafeArea(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Card(
                            elevation: 7,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Expanded(
                                    child: Image.asset('/mahindra-logo.png'),
                                  ),
                                  SizedBox(
                                    height: 24.0,
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Flexible(
                                          child: TextFormField(
                                            onFieldSubmitted: (value) {
                                              _email = value;
                                              print('Submitted');
                                              login();
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                            ],
                                            style: theme.textTheme.bodyText2
                                                .copyWith(fontSize: 20),
                                            maxLines: 1,
                                            maxLength: 10,
                                            decoration: InputDecoration(
                                              labelText: 'Token Number',
                                              labelStyle:
                                                  theme.textTheme.bodyText2,
                                            ),
                                            // validator: (email) {
                                            //   return Validators.validateEmail(email)
                                            //       ? null
                                            //       : 'Enter valid Token Number';
                                            // },
                                            onChanged: (value) {
                                              _email = value;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.0,
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      'Login',
                                    ),
                                    onPressed: () async {
                                      login();
                                    },
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Expanded(
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: TextButton(
                                          child: Text(
                                            'Terms and Conditions',
                                            style: textTheme.caption,
                                          ),
                                          onPressed: () {},
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/BBS_Analysis/BBSBase.dart';
import 'package:mahindra_chakkan_analysis/BBS_Complaince_Schedule/scheduleBase.dart';
import 'package:mahindra_chakkan_analysis/login/loginBase.dart';
import 'package:mahindra_chakkan_analysis/utils/somethingWentWrong.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String selection = '';
  String title = 'Home';

  Widget decider() {
    switch (selection) {
      case 'BBS':
        return BBSBase();
        break;

      case 'compliance':
        return ScheduleBase();
        break;
      default:
        return wrong('widget');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .2,
            child: ListView(
              children: [
                SizedBox(height: 15),
                ListTile(
                    title: Text(
                  'Menu',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                )),
                SizedBox(
                  height: 15,
                ),
                ExpansionTile(
                  title: Text('BBS'),
                  children: [
                    ListTile(
                      title: Text('BBS Analysis'),
                      onTap: () {
                        if (selection != 'BBS') {
                          setState(() {
                            title = 'BBS Analysis';
                            selection = 'BBS';
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: Text('BBS Compliance Schedule'),
                      onTap: () {
                        if (selection != 'compliance') {
                          setState(() {
                            title = 'BBS Compliance Schedule';
                            selection = 'compliance';
                          });
                        }
                      },
                    ),
                  ],
                ),
                ListTile(
                  title: Text('Incident Analysis'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('SOT Analysis'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          VerticalDivider(
            color: Colors.black38,
            thickness: 1.5,
            indent: 0,
            endIndent: 0,
          ),
          Expanded(
              child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: [
                IconButton(
                    icon: Icon(Icons.power_settings_new_outlined),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => LoginBase(),
                      ));
                    })
              ],
            ),
            body: decider(),
          ))
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

enum ScheduleStates {
  loading,
  view,
}

class ScheduleProvider extends ChangeNotifier {
  ScheduleStates state = ScheduleStates.loading;

  List<dynamic> docList = [];

  Map<String, dynamic> responseMap = {};
  Map<String, dynamic> dates = {};

  List<Map<String, dynamic>> assessorList = [];

  DateTime selectedDate = DateTime.now();

  String selectedMonth = DateFormat('MMM - y').format(DateTime.now());

  ScheduleProvider() {
    getData();
  }

  void getData() async {
    final uri = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/safety-app-6aa58/databases/(default)/documents/BBSObservations?&pageSize=100000');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      responseMap = jsonDecode(response.body);
      docList = responseMap['documents'];
      await process();
      getDates();
    } else {
      responseMap = {'body': 'Failed to load'};
    }
    state = ScheduleStates.view;
    notifyListeners();
  }

  Future<void> process() async {
    print('New Process');
    assessorList = [];
    for (var observation in docList) {
      int timeiso = int.parse(observation['fields']['time']['integerValue']);
      DateTime recordDate = DateTime.fromMillisecondsSinceEpoch(timeiso);

      if (recordDate.month == selectedDate.month &&
          recordDate.year == selectedDate.year) {
        String assessor = observation['fields']['assessor']['stringValue'];

        int weekOfMonth = getWeek(recordDate);
        int index =
            assessorList.indexWhere((element) => element['uid'] == assessor);
        if (index == -1) {
          Map<String, dynamic> map = {
            'uid': assessor,
            'observations': allotNewMap(weekOfMonth),
            'count': 1
          };
          assessorList.add(map);
        } else {
          assessorList[index]['observations'][weekOfMonth - 1]['compliance'] =
              true;
          assessorList[index]['count']++;
        }
      }
    }
    await getNames();
    print(assessorList.toString());
  }

  void updateSelectedDate(DateTime date) async {
    selectedDate = date;
    selectedMonth = DateFormat('MMM - y').format(date);
    state = ScheduleStates.loading;
    notifyListeners();
    await process();
    getDates();
    state = ScheduleStates.view;
    notifyListeners();
  }

  int getWeek(DateTime recordDate) {
    String firstDay = recordDate.toString().substring(0, 8) +
        '01' +
        recordDate.toString().substring(10);
    int weekDay = DateTime.parse(firstDay).weekday;

    if (weekDay == 7) {
      weekDay = 0;
    }
    int weekOfMonth = ((recordDate.day + weekDay) / 7).ceil();

    return weekOfMonth;
  }

  Future<void> getNames() async {
    for (var assessor in assessorList) {
      http.Response response = await http.get(Uri.https(
          'firestore.googleapis.com',
          'v1/projects/safety-app-6aa58/databases/(default)/documents/users/' +
              assessor['uid']));

      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        assessor['name'] = res['fields']['name']['stringValue'];
      } else {
        assessor['name'] = 'Not Found';
      }
    }
  }

  List<Map<String, dynamic>> allotNewMap(int weekOfMonth) {
    List<Map<String, dynamic>> map = [];

    map = List.generate(
        5,
        (index) => {
              'week': index + 1,
              'compliance': (weekOfMonth == index + 1) ? true : false
            });

    return map;
  }

  void getDates() {
    DateTime firstDay = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime week1Start = firstDay.subtract(Duration(days: firstDay.weekday));

    for (var i = 0; i < 5; i++) {
      String keyS = 'week' + i.toString() + 'start';
      String keyE = 'week' + i.toString() + 'end';
      DateTime current = week1Start.add(Duration(days: 7 * i));
      dates[keyS] = current.day.toString() + '/' + current.month.toString();
      dates[keyE] = current.add(Duration(days: 6)).day.toString() +
          '/' +
          current.add(Duration(days: 6)).month.toString();
    }
    print(dates.toString());
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahindra_chakkan_analysis/BBS_Analysis/bar_chart_model.dart';

class BBSProvider extends ChangeNotifier {
  Map<String, dynamic> responseMap = {};

  List<dynamic> docList = [];

  List<Map<String, dynamic>> catList = [];

  List<BarChartModel> data = [];

  List<DropdownMenuItem> puList = [];

  List<String> puListString = ['Plant'];

  int chartIndex = -1;
  int closurePercent;
  int totalObservations;
  int within10Days;
  int within30Days;
  int moreThan30Days;
  int closed;
  int open;
  int safeAct;
  int safeSituation;
  int unsafeAct;
  int unsafeSituation;

  double uaucr;
  double ssph;
  double usph;

  bool loading = true;

  String chartTitle;
  String selectedPu = 'Plant';

  DateTime startDate = DateTime(2019);
  DateTime endDate = DateTime.now();

  BBSProvider() {
    getData();
  }

  Future<void> getData() async {
    final uri = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/safety-app-6aa58/databases/(default)/documents/BBSObservations?&pageSize=100000');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      responseMap = jsonDecode(response.body);
      print(responseMap['documents'].toString());
      docList = responseMap['documents'];
      print('DocList = ' + docList.toString());
      catProcess();
      figProcess();
      makeDropDown();
    } else {
      responseMap = {'body': 'Failed to load'};
    }
    loading = false;
    notifyListeners();
  }

  //Process For Categories
  void catProcess() {
    catList = [];
    for (var observation in docList) {
      var start = int.parse(observation['fields']['time']['integerValue']);
      if (startDate.millisecondsSinceEpoch < start &&
          endDate.millisecondsSinceEpoch > start) {
        addPu(observation['fields']['pu']['stringValue']);
        String cat = observation['fields']['category']['stringValue'];
        String subCat = observation['fields']['subCategory']['stringValue'];
        int index = catList.indexWhere((element) => element['name'] == cat);
        if (index == -1) {
          Map<String, dynamic> map = {'name': cat, 'count': 1, subCat: 1};
          catList.add(map);
        } else {
          catList[index]['count']++;

          if (!catList[index].containsKey(subCat)) {
            catList[index][subCat] = 1;
          } else {
            catList[index][subCat]++;
          }
        }
      }
    }
    makeChartData();
    // print(catList.toString());
  }

  void addPu(String pu) {
    if (!puListString.contains(pu)) {
      puListString.add(pu);
    }
  }

  void makeDropDown() {
    puList = List.generate(
        puListString.length,
        (index) => DropdownMenuItem(
              child: Text(puListString[index]),
              value: puListString[index],
            ));
  }

  //Refresh Chart Data
  void makeChartData() {
    data = [];
    if (chartIndex == -1) {
      chartTitle = 'Category';
      for (var item in catList) {
        BarChartModel bcm = BarChartModel(
            name: item['name'] + '(' + item['count'].toString() + ')',
            count: item['count']);
        data.add(bcm);
      }
    } else {
      var count = catList[chartIndex].keys;
      chartTitle = 'Sub- Category';
      for (var item in count) {
        if (item != 'name' && item != 'count') {
          BarChartModel bcm = BarChartModel(
              name: item + '(' + catList[chartIndex][item].toString() + ')',
              count: catList[chartIndex][item]);
          data.add(bcm);
        }
      }
    }
    notifyListeners();
  }

  //After bar is selected on chart
  void chartSelected(int index) {
    chartIndex = index;
    makeChartData();
  }

  //Process for figures
  void figProcess() {
    closed = 0;
    open = 0;
    safeAct = 0;
    safeSituation = 0;
    unsafeAct = 0;
    unsafeSituation = 0;
    uaucr = 0;
    ssph = 0;
    usph = 0;
    within10Days = 0;
    within30Days = 0;
    moreThan30Days = 0;
    totalObservations = docList.length;
    for (var observation in docList) {
      var start = int.parse(observation['fields']['time']['integerValue']);
      if (startDate.millisecondsSinceEpoch < start &&
          endDate.millisecondsSinceEpoch > start) {
        if (observation['fields']['status']['stringValue'] == 'Closed') {
          closed++;
          DateTime start = DateTime.fromMillisecondsSinceEpoch(
              int.parse(observation['fields']['time']['integerValue']));
          DateTime end = DateTime.fromMillisecondsSinceEpoch(
              int.parse(observation['fields']['closureDate']['integerValue']));
          final days = end.difference(start).inDays;
          if (days < 10) {
            within10Days++;
          } else if (days > 10 && days < 30) {
            within30Days++;
          } else {
            moreThan30Days++;
          }
        } else {
          open++;
        }
        switch (observation['fields']['observationType']['stringValue']) {
          case ('Safe act'):
            safeAct++;
            break;

          case ('Safe condition'):
            safeSituation++;
            break;

          case ('Unsafe act'):
            unsafeAct++;
            break;

          case ('Unsafe condition'):
            unsafeSituation++;
            break;

          default:
        }
      }
    }
    uaucr = unsafeAct / unsafeSituation;
    ssph = (safeAct + safeSituation) / totalObservations;
    usph = (unsafeAct + unsafeSituation) / totalObservations;
    closurePercent = (closed * 100 ~/ docList.length);
  }

  void updateSelectedDate({DateTime startDateNew, DateTime endDateNew}) {
    loading = true;
    notifyListeners();
    if (startDateNew != null) {
      print('dateUpdate');
      startDate = startDateNew;
    }
    if (endDateNew != null) {
      print('enddateUpdate');
      endDate = endDateNew;
    }
    catProcess();
    figProcess();
    loading = false;
    notifyListeners();
  }

  void updatePu(String pu) {
    selectedPu = pu;
    notifyListeners();
  }
}

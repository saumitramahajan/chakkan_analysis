import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/BBS_Complaince_Schedule/scheduleProvider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

Widget view(ScheduleProvider provider, BuildContext context) {
  return Container(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Currently selected Month:'),
            Text(provider.selectedMonth),
            ElevatedButton(
                onPressed: () {
                  showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 1),
                    lastDate: DateTime(2050, 12),
                    initialDate: provider.selectedDate ?? DateTime.now(),
                    locale: Locale("en"),
                  ).then((date) {
                    if (date != null) {
                      provider.updateSelectedDate(date);
                    }
                  });
                },
                child: Text('Set Month'))
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 05, 16, 5),
          child: Row(
            children: [
              Flexible(fit: FlexFit.tight, child: Text('Name'), flex: 3),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(provider.dates['week0start'] +
                        ' - ' +
                        provider.dates['week0end']),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(provider.dates['week1start'] +
                        ' - ' +
                        provider.dates['week1end']),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(provider.dates['week2start'] +
                        ' - ' +
                        provider.dates['week2end']),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(provider.dates['week3start'] +
                        ' - ' +
                        provider.dates['week3end']),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(provider.dates['week4start'] +
                        ' - ' +
                        provider.dates['week4end']),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Total'),
                  )),
            ],
          ),
        ),
        ListView.builder(
          itemCount: provider.assessorList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          child: Text(provider.assessorList[index]['name']),
                          flex: 3),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: provider.assessorList[index]['observations'][
                                provider.assessorList[index]['observations']
                                    .indexWhere((element) =>
                                        element['week'] == 1)]['compliance']
                            ? Icon(
                                Icons.done_outline_rounded,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                              ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: provider.assessorList[index]['observations'][
                                provider.assessorList[index]['observations']
                                    .indexWhere((element) =>
                                        element['week'] == 2)]['compliance']
                            ? Icon(
                                Icons.done_outline_rounded,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                              ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: provider.assessorList[index]['observations'][
                                provider.assessorList[index]['observations']
                                    .indexWhere((element) =>
                                        element['week'] == 3)]['compliance']
                            ? Icon(
                                Icons.done_outline_rounded,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                              ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: provider.assessorList[index]['observations'][
                                provider.assessorList[index]['observations']
                                    .indexWhere((element) =>
                                        element['week'] == 4)]['compliance']
                            ? Icon(
                                Icons.done_outline_rounded,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                              ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: provider.assessorList[index]['observations'][
                                provider.assessorList[index]['observations']
                                    .indexWhere((element) =>
                                        element['week'] == 5)]['compliance']
                            ? Icon(
                                Icons.done_outline_rounded,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                              ),
                      ),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(provider.assessorList[index]['count']
                                .toString()),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    ),
  );
}

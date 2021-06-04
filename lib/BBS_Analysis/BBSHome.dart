import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/BBS_Analysis/BBSProvider.dart';
import 'package:mahindra_chakkan_analysis/BBS_Analysis/bar_charts.dart';
import 'package:mahindra_chakkan_analysis/BBS_Analysis/figures.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

class BBSHome extends StatefulWidget {
  @override
  _BBSHomeState createState() => _BBSHomeState();
}

class _BBSHomeState extends State<BBSHome> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BBSProvider>(context);
    return Container(
        child: Center(
            child: provider.loading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Flexible(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text('Start Date:'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          showMonthPicker(
                                            context: context,
                                            firstDate: DateTime(2018, 1),
                                            lastDate: DateTime.now(),
                                            initialDate: provider.startDate ??
                                                DateTime.now(),
                                            locale: Locale("en"),
                                          ).then((date) {
                                            if (date != null) {
                                              provider.updateSelectedDate(
                                                  startDateNew: date);
                                            }
                                          });
                                        },
                                        child: Text(provider.startDate.month
                                                .toString() +
                                            ' - ' +
                                            provider.startDate.year
                                                .toString())),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('End Date:'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          showMonthPicker(
                                            context: context,
                                            firstDate: DateTime(2018, 1),
                                            lastDate: DateTime.now(),
                                            initialDate: provider.endDate ??
                                                DateTime.now(),
                                            locale: Locale("en"),
                                          ).then((date) {
                                            if (date != null) {
                                              provider.updateSelectedDate(
                                                  endDateNew: date);
                                            }
                                          });
                                        },
                                        child: Text(provider.endDate.month
                                                .toString() +
                                            ' - ' +
                                            provider.endDate.year.toString())),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Selected PU:'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    DropdownButton(
                                      items: provider.puList,
                                      onChanged: (val) {
                                        provider.updatePu(val);
                                      },
                                      value: provider.selectedPu,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      Flexible(
                        child: Card(
                            elevation: 7.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: barCharts(provider),
                            )),
                        flex: 10,
                      ),
                      Flexible(
                        child: Card(
                            elevation: 7.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: figures(provider),
                            )),
                        flex: 10,
                      ),
                    ],
                  )));
  }
}

import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/BBS_Analysis/BBSProvider.dart';
import 'package:mahindra_chakkan_analysis/BBS_Analysis/bar_charts.dart';
import 'package:mahindra_chakkan_analysis/BBS_Analysis/figures.dart';
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
                        child: Card(
                            elevation: 7.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: barCharts(provider),
                            )),
                        flex: 1,
                      ),
                      Flexible(
                        child: Card(
                            elevation: 7.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: figures(provider),
                            )),
                        flex: 1,
                      ),
                    ],
                  )));
  }
}

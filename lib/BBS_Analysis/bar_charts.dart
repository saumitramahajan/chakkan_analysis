import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mahindra_chakkan_analysis/BBS_Analysis/bar_chart_model.dart';
import 'BBSProvider.dart';

Widget barCharts(BBSProvider provider) {
  List<charts.Series<BarChartModel, String>> series = [
    charts.Series(
        id: "Category",
        data: provider.data,
        domainFn: (BarChartModel series, _) => series.name,
        measureFn: (BarChartModel series, _) => series.count),
  ];
  return Container(
    child: Center(
      child: Column(
        children: [
          Row(
            children: [
              (provider.chartIndex != -1)
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        provider.chartSelected(-1);
                      })
                  : SizedBox(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(provider.chartTitle,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              child: charts.BarChart(
            series,
            animate: false,
            selectionModels: [
              new charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: (model) {
                  if (provider.chartIndex == -1) {
                    provider.chartSelected(model.selectedDatum.first.index);
                  }
                },
              ),
            ],
          )),
        ],
      ),
    ),
  );
}

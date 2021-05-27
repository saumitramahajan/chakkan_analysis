import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/BBS_Analysis/BBSProvider.dart';

Widget figures(BBSProvider provider) {
  return Container(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Parameters',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Precentage Closure of Observations: ' +
                      provider.closurePercent.toString() +
                      '%'),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Total Open: ' + provider.open.toString()),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Total Closed: ' + provider.closed.toString()),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Total Observations: ' +
                      provider.totalObservations.toString()),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              Column(
                children: [
                  Text('Closed Within 10 Days: ' +
                      provider.within10Days.toString()),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Closed Withi 30 Days: ' +
                      provider.within30Days.toString()),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Closed After 30 Days: ' +
                      provider.moreThan30Days.toString()),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              Column(
                children: [
                  Text('Unsafe act/Unsafe Condition Ratio: ' +
                      provider.uaucr.toStringAsFixed(3)),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Safe Situations per Hour: ' +
                      provider.ssph.toStringAsFixed(3)),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Unsafe Situations per Hour: ' +
                      provider.usph.toStringAsFixed(3)),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

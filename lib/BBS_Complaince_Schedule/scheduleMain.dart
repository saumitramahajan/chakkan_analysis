import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/BBS_Complaince_Schedule/scheduleProvider.dart';
import 'package:mahindra_chakkan_analysis/BBS_Complaince_Schedule/view.dart';
import 'package:mahindra_chakkan_analysis/utils/loading.dart';
import 'package:mahindra_chakkan_analysis/utils/somethingWentWrong.dart';
import 'package:provider/provider.dart';

class ScheduleMain extends StatefulWidget {
  @override
  _ScheduleMainState createState() => _ScheduleMainState();
}

class _ScheduleMainState extends State<ScheduleMain> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleProvider>(context);
    Widget selector() {
      Widget widget = wrong('widget');
      switch (provider.state) {
        case ScheduleStates.loading:
          widget = loading('widget');
          break;
        case ScheduleStates.view:
          widget = view(provider, context);
          break;
      }
      return widget;
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: selector(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/BBS_Complaince_Schedule/scheduleMain.dart';
import 'package:mahindra_chakkan_analysis/BBS_Complaince_Schedule/scheduleProvider.dart';
import 'package:provider/provider.dart';

class ScheduleBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleProvider(),
      child: ScheduleMain(),
    );
  }
}

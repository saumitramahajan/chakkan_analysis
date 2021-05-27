import 'package:flutter/material.dart';
import 'package:mahindra_chakkan_analysis/BBS_Analysis/BBSHome.dart';
import 'package:mahindra_chakkan_analysis/BBS_Analysis/BBSProvider.dart';
import 'package:provider/provider.dart';

class BBSBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BBSProvider(),
      child: BBSHome(),
    );
  }
}

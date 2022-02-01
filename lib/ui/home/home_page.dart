import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/constants.dart';
import 'package:habit_tracker_flutter/ui/ui.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: Center(
        child: SizedBox(
          width: 150,
          child: AnimatedTask(iconName: AppAssets.dog),
        ),
      ),
    );
  }
}

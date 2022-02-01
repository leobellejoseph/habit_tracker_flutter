import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/constants.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/ui.dart';

class TaskWithName extends StatelessWidget {
  final TaskPreset task;
  const TaskWithName({Key? key, required this.task}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedTask(iconName: task.iconName),
        const SizedBox(height: 8),
        Text(
          task.name.toUpperCase(),
          textAlign: TextAlign.center,
          style:
              TextStyles.taskName.copyWith(color: AppTheme.of(context).accent),
        )
      ],
    );
  }
}

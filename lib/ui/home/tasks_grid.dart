import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name.dart';

class TasksGrid extends StatelessWidget {
  final List<TaskPreset> tasks;
  const TasksGrid({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView.builder(
            itemCount: tasks.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
              childAspectRatio: 0.75,
              mainAxisSpacing: 15,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskWithName(task: task);
            });
      },
    );
  }
}

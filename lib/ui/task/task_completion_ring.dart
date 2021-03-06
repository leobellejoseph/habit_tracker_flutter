import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/ui.dart';

class TaskCompletionRing extends StatelessWidget {
  final double progress;
  const TaskCompletionRing({Key? key, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = AppTheme.of(context);
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: RingPainter(
            progress: progress,
            taskNotCompletedColor: themeData.taskRing,
            taskCompletedColor: themeData.accent),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double progress;
  final Color taskCompletedColor;
  final Color taskNotCompletedColor;
  const RingPainter({
    required this.progress,
    required this.taskCompletedColor,
    required this.taskNotCompletedColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final notCompleted = progress < 1.0;
    final strokeWidth = size.width / 12.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        notCompleted ? (size.width - strokeWidth) / 2 : size.width / 2;
    if (notCompleted) {
      final paint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = taskNotCompletedColor
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, paint);
    }
    final foreground = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskCompletedColor
      ..style = notCompleted ? PaintingStyle.stroke : PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foreground,
    );
  }

  @override
  bool shouldRepaint(RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

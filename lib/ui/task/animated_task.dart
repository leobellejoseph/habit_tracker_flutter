import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/ui.dart';

class AnimatedTask extends StatefulWidget {
  final String iconName;
  const AnimatedTask({Key? key, required this.iconName}) : super(key: key);

  @override
  _AnimatedTaskState createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animationCurve;
  bool _showCheckIcon = false;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller.reverseDuration = Duration(milliseconds: 500);
    animationCurve = controller.drive(
      CurveTween(curve: Curves.fastLinearToSlowEaseIn),
    );
    controller.addStatusListener(_checkStatusUpdates);
  }

  void _checkStatusUpdates(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (mounted) {
        setState(() => _showCheckIcon = true);
      }
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _showCheckIcon = false);
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    controller.removeStatusListener(_checkStatusUpdates);
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (controller.status != AnimationStatus.completed) {
      controller.forward();
    } else if (!_showCheckIcon) {
      controller.value = 0;
    }
  }

  void _handleTapCancel() {
    if (controller.status != AnimationStatus.completed) {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = AppTheme.of(context);
    return GestureDetector(
      onDoubleTap: () => controller.reset(),
      onTapDown: _handleTapDown,
      onTapUp: (_) => _handleTapCancel(),
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: animationCurve,
        builder: (context, _) {
          final progress = animationCurve.value;
          final hasCompleted = progress == 1.0;
          final iconColor =
              hasCompleted ? themeData.taskCompleted : themeData.taskIcon;

          return Stack(
            children: [
              TaskCompletionRing(progress: animationCurve.value),
              Positioned.fill(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: hasCompleted
                      ? animationCurve.value
                      : (animationCurve.value - 1.0).abs(),
                  child: CenteredSvgIcon(
                      iconName: hasCompleted && _showCheckIcon
                          ? AppAssets.check
                          : widget.iconName,
                      color: iconColor),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

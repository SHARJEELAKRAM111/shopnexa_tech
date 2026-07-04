import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final int endValue;
  final String suffix;
  final TextStyle style;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.endValue,
    required this.suffix,
    required this.style,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: endValue.toDouble()),
      duration: duration,
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Text(
          '${value.toInt()}$suffix',
          style: style,
        );
      },
    );
  }
}

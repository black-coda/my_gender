import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key, this.isActive =false,
  });
final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive
      ? 18
      : 6,
      width: isActive
      ? 18
      : 12,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        // borderRadius: BorderRadius.circular(),
        shape: BoxShape.circle,
      ),
    );
  }
}
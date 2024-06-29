import 'package:flutter/material.dart';

class ButtonUpWidget extends StatelessWidget {
  const ButtonUpWidget({
    super.key, this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 8,
      ),  
      child:  Text('Next', style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.onTertiary,
        fontWeight: FontWeight.bold,
      )),
    );
  }
}
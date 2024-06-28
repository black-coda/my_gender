import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Onboard2 extends StatelessWidget {
  const Onboard2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/lottie_2.json'),
            Text(
              'Track your period',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    // fontSize: 40,
                  ),
            ),
            const SizedBox(height: 40),
            Text(
              'Log your period dates, flow intensity, and symptoms to better understand your cycle.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

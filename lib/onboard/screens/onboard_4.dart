import 'package:flutter/material.dart';
import 'package:my_gender/utils/constants/konstant.dart';

class Onboard4 extends StatelessWidget {
  const Onboard4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Konstant.sizedBoxHeight16,
            Konstant.sizedBoxHeight16,
            Text(
              'Menstrual Education with AI',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    // fontSize: 40,
                  ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/onboard4.png',
              height: 300,
              width: 300,
            ),
            const SizedBox(height: 30),
            Text(
                textAlign: TextAlign.center,
                'Learn about your menstrual cycle and get personalized insights from our AI-powered assistant.',
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

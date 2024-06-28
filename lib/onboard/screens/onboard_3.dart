import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Onboard3 extends StatelessWidget {
  const Onboard3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * .4,
              decoration: const BoxDecoration(),
              child: Lottie.asset("assets/lottie/onboard.json"),
            ),
            const SizedBox(height: 50),
            Text(
              'Menstrual Education',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              textAlign: TextAlign.center,
              'Stay informed and in control: Your journey to menstrual wellness starts with understanding your cycle.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

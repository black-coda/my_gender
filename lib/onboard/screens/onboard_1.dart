import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Onboard1 extends StatelessWidget {
  const Onboard1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            children: [
              Text('MyGender',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontFamily: "DS",
                      )),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Lottie.asset("assets/lottie/onboard_1_animate.json"),
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Empowering Menstrual Health with Smart Technology',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

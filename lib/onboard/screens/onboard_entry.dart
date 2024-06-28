// Suggested code may be subject to a license. Learn more: ~LicenseLog:923516635.
import 'package:flutter/material.dart';

import '../widgets/dot_indicator.dart';
import 'intro_screen.dart';
import 'onboard_1.dart';
import 'onboard_2.dart';
import 'onboard_3.dart';
import 'onboard_4.dart';
import 'onboard_question1.dart';
import 'onboard_question_2.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  final List<Widget> _pages = const [
    Onboard1(),
    Onboard2(),
    Onboard3(),
    Onboard4(),
    OnboardQuestion1(),
    OnboardQuestion2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  if (currentPage < _pages.length) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                icon: const Text("Next",
                    style: TextStyle(fontWeight: FontWeight.bold)))
          ],
          leading: currentPage > 0
              ? IconButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Text("Prev",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
              : null),
      body: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: _pages,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(children: [
                      ...List.generate(
                        _pages.length,
                        (index) => DotIndicator(
                          isActive: index == currentPage,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                      height: 60,
                      width: 80,
                      child: currentPage == _pages.length - 1
                          ? TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const IntroScreen()));
                              },
                              child: const Text("Finish"))
                          : TextButton(
                              onPressed: () {
                                _pageController.jumpToPage(_pages.length - 1);
                              },
                              child: const Text('Skip'),
                            )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

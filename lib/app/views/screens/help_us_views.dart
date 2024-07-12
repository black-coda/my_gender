import 'package:flutter/material.dart';
import 'package:my_gender/utils/rich_text/base_text.dart';
import 'package:my_gender/utils/rich_text/ric_text_widgte.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        // backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Introduction Section
              const Text(
                'Welcome to Menstrual App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'This app helps you track your menstrual cycle, log symptoms, and set reminders. Here’s how to get started:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Navigation Section
              const Text(
                'Navigation',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
              const SizedBox(height: 10),
              const Text(
                'Use the bottom navigation bar to move between different sections of the app. Tap on each tab to access features like period tracking, calendar view, and settings.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Features Section
              const Text(
                'Features',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
              const SizedBox(height: 10),
              const Text(
                '1. Track Periods: Log your period dates and predict your next cycle.\n'
                '2. Log Symptoms: Record symptoms such as cramps, mood swings, and more.\n'
                '3. Set Reminders: Get reminders for taking medication, upcoming periods, etc.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // FAQs Section
              const Text(
                'Frequently Asked Questions',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
              const SizedBox(height: 10),
              const ExpansionTile(
                title: Text('How do I log a new period?'),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'To log a new period, go to the "Period Tracker" tab and tap on the "+" button. Select the start and end dates and save.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const ExpansionTile(
                title: Text('Can I edit my symptoms?'),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Yes, you can edit symptoms by going to the "Symptoms Log" tab, selecting the entry you want to edit, and making the changes.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              // Add more FAQs as needed

              // Contact Us Section
              const Text(
                'Contact Us',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
              const SizedBox(height: 10),
              RichTextWidget(
                texts: [
                  BaseText.plain(
                      text:
                          'If you have any questions or need further assistance, check out '),
                  BaseText.link(
                      text: "Flow",
                      onTapped: () async {
                        await launchUrl(Uri.parse(
                            "https://flo.health/product-tour/tracking-cycle"));
                      },
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

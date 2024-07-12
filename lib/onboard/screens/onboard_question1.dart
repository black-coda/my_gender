import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OnboardQuestion1 extends StatefulWidget {
  const OnboardQuestion1({super.key});

  @override
  State<OnboardQuestion1> createState() => _OnboardQuestion1State();
}

class _OnboardQuestion1State extends State<OnboardQuestion1> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('When were you born?'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "By knowing your birth year, we can tailor the app's insights and recommendations to be more relevant to your age group.",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),

                  textAlign: TextAlign.center,
            ),
             SizedBox(height: MediaQuery.sizeOf(context).height *.2),
            SizedBox(
              width: double.maxFinite,
              child: TextButton(
                onPressed: () => _selectDate(context),
// Suggested code may be subject to a license. Learn more: ~LicenseLog:777890442.
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 20,
                  shadowColor: Theme.of(context).colorScheme.secondary,
                ),

                child: Text(
                  DateFormat('MMMM dd, yyyy').format(selectedDate),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

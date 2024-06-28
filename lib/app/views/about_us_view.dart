import 'package:flutter/material.dart';
import 'package:my_gender/app/widgets/dp_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('About Us', style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to MyGender!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'MyGender is a one-stop app designed to provide young girls with accurate and reliable menstrual education and resources. Our mission is to empower young girls with the knowledge and tools they need to understand and manage their menstrual health with confidence and ease.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'About MyGender',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Comprehensive Menstrual Education\n'
              '• Personalized AI Chatbot\n'
              '• Resource Hub\n',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Meet the Team',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              children: const [
                DpWidget(
                    name: "Otitologbon Oluwabunmi O.",
                    role: "C.E.O MyGender, Developer, UI/UX",
                    githubUrl: "https://github.com/oluwabunmi1024",
                    imgUrl:
                        "https://github.com/black-coda/image-host/blob/main/WhatsApp%20Image%202024-06-13%20at%2015.18.01_4e735e4a.jpg?raw=true"),
                DpWidget(
                    name: "Solomon Monday",
                    role: "Mobile Developer",
                    githubUrl: "https://github.com/black-coda",
                    imgUrl:
                        "https://github.com/black-coda/image-host/blob/main/IMG_20231122_154002_911.jpg?raw=true"),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Our Vision',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We believe that every girl deserves access to reliable menstrual health information and resources. Our vision is to create a supportive and empowering environment where young girls can learn, ask questions, and take control of their menstrual health with confidence.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Thank you for choosing MyGender. Together, we\'re making menstrual health education accessible and empowering for all.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'For any feedback or inquiries, feel free to reach out to us at botitologbon@gmail.com. We are always here to help and support you on your menstrual health journey.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

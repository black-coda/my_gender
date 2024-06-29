import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DpWidget extends StatelessWidget {
  const DpWidget(
      {super.key,
      required this.name,
      required this.role,
      required this.imgUrl,
      required this.githubUrl});

  final String name;
  final String role;
  final String imgUrl;
  final String githubUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(name),
      subtitle: Text(role),
      trailing: IconButton(
        onPressed: () {
          launchUrl(Uri.parse(githubUrl));
        },
        icon: const FaIcon(FontAwesomeIcons.github),
      ),
    );
  }
}

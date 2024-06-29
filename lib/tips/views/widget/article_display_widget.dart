import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArticleDisplayWidget extends StatelessWidget {
  const ArticleDisplayWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
        // horizontalTitleGap: 12,

        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        tileColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Container(
          // height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: const Center(child: FaIcon(FontAwesomeIcons.bullhorn)),
        ),
        title: Text(
          title,
        ),
        subtitle: Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

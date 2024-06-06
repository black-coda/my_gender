// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'base_text.dart';
import 'link_text.dart.dart';



class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.texts,
    this.styleAll,
  });

  final Iterable<BaseText> texts;
  final TextStyle? styleAll;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map(
          (baseText) {
            if (baseText is LinkText) {
              return TextSpan(
                text: baseText.text,
                style: styleAll?.merge(baseText.style),
                recognizer: TapGestureRecognizer()..onTap = baseText.onTapped,
              );
            } else {
              return TextSpan(
                text: baseText.text,
                style: styleAll?.merge(baseText.style),
              );
            }
          },
        ).toList(),
      ),
    );
  }
}

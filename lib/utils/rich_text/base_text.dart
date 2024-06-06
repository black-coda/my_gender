// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart'
    show Colors, TextStyle, VoidCallback, immutable;

import 'link_text.dart.dart';


@immutable
class BaseText {
  final String text;
  final TextStyle? style;
  const BaseText({
    required this.text,
    this.style,
  });

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) {
    return BaseText(text: text, style: style);
  }

  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style = const TextStyle(color: Colors.blue),
  }) {
    return LinkText(
      text: text,
      style: style,
      onTapped: onTapped,
    );
  }
}

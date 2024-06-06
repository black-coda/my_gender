import 'package:flutter/material.dart' show Color;
import 'package:my_gender/extensions/string/remove_all.dart';


extension AsHtmlColorToColor on String {
  Color htmlColorToColor() => Color(
        int.parse(
          removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
}

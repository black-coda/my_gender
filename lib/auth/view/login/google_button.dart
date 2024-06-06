import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_gender/utils/constants/app_colors.dart';
import 'package:my_gender/utils/constants/strings.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.google,
            color: AppColors.googleColor,
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Text(Strings.google)
        ],
      ),
    );
  }
}

class GButton extends StatelessWidget {
  const GButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.arrowRight,
            color: AppColors.googleColor,
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Text(Strings.continueToApp)
        ],
      ),
    );
  }
}

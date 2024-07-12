import 'dart:developer';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gender/auth/controllers/auth_state_provider.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';
import 'package:my_gender/utils/constants/konstant.dart';
import 'package:my_gender/utils/image_picker_method.dart';
import 'package:my_gender/utils/theme/service/theme_setting_service.dart';

import 'edit_profile_view.dart';
import 'update_user_password.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final photoUrl = ref.watch(firebaseProvider).currentUser?.photoURL;

    Uint8List? imageBytes;

    void selectImage() async {
      final Uint8List img = await pickImage(ImageSource.gallery);

      setState(() {
        imageBytes = img;
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 80,
                foregroundImage: CachedNetworkImageProvider(
                  photoUrl ??
                      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                ),
              ),
              Konstant.sizedBoxHeight16,
              const PersonalSettingsWidget("PROFILE"),
              Konstant.sizedBoxHeight8,
              const ThemeSettingsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeSettingsWidget extends ConsumerWidget {
  const ThemeSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "THEME",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const ThemeModeSelectorWidget(),
          Konstant.sizedBoxHeight4,
          Divider(color: Theme.of(context).dividerColor, thickness: 1),
          Konstant.sizedBoxHeight4,
          Text(
            "Highlight Color",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 16),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
          Konstant.sizedBoxHeight8,
          ThemeColorSelectorWidget(
            onColorSelected: (color) {
              log("pressed");
              ref
                  .watch(settingsServiceProvider.notifier)
                  .modifyThemeColor(color);
            },
          ),
        ],
      ),
    );
  }
}

class ThemeModeSelectorWidget extends ConsumerWidget {
  const ThemeModeSelectorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
          dense: true,
          leading: const Icon(Icons.light_mode),
          title: const Text('Light'),
          onTap: () {
            log("tapped light");
            ref
                .read(settingsServiceProvider.notifier)
                .modifyThemeMode(ThemeMode.light);
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.dark_mode,
          ),
          title: const Text('Dark'),
          onTap: () {
            log("tapped dark");
            ref
                .read(settingsServiceProvider.notifier)
                .modifyThemeMode(ThemeMode.dark);
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.devices),
          title: const Text('system'),
          onTap: () {
            log("tapped system");
            ref
                .read(settingsServiceProvider.notifier)
                .modifyThemeMode(ThemeMode.system);
          },
        ),
      ],
    );
  }
}

class ThemeColorSelectorWidget extends StatelessWidget {
  final Function(MaterialColor) onColorSelected;
  final List<MaterialColor> colors = [
    Colors.green,
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
  ];

  ThemeColorSelectorWidget({super.key, required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        children: colors.map((color) {
          return GestureDetector(
            onTap: () => onColorSelected(color),
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class PersonalSettingsWidget extends ConsumerWidget {
  const PersonalSettingsWidget(this.headline, {super.key});

  final String headline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headline,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditProfileView(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const UpdateUserPassword(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: ref.read(authStateProvider.notifier).logOut,
          ),
        ],
      ),
    );
  }
}

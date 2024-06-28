import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/app/views/about_us_view.dart';
import 'package:my_gender/app/views/screens/help_us_views.dart';
import 'package:my_gender/auth/controllers/auth_state_provider.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';
import 'package:my_gender/users/views/edit_profile_view.dart';
import 'package:my_gender/users/views/user_profle.dart';
import 'package:my_gender/utils/constants/konstant.dart';

class MainViewDrawer extends ConsumerWidget {
  const MainViewDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName = ref.watch(firebaseProvider).currentUser?.displayName;
    final photoUrl = ref.watch(firebaseProvider).currentUser?.photoURL;
    final updatedPhotoUrl = ref.watch(photoUrlProvider.notifier).state;
    log(displayName.toString());
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          LayoutBuilder(builder: (context, constraint) {
            return DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                children: [
                  updatedPhotoUrl == null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            photoUrl ??
                                'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                          ),
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: MemoryImage(
                            updatedPhotoUrl,
                          ),
                        ),
                  Konstant.sizedBoxHeight8,
                  Text(displayName ?? "",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              )),
                  Konstant.sizedBoxHeight4,
                  Text(ref.watch(firebaseProvider).currentUser!.email ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          )),
                ],
              ),
            );
          }),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserProfileScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_rounded),
            title: const Text('Notifications'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About Us'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const AboutUsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outlined),
            title: const Text('Help'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const HelpScreen();
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('logout'),
            onTap: () {
              ref.watch(authStateProvider.notifier).logOut();
            },
          ),
        ],
      ),
    );
  }
}

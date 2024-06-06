import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/auth/controllers/auth_state_provider.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';
import 'package:my_gender/utils/constants/konstant.dart';

class MainViewDrawer extends ConsumerWidget {
  const MainViewDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName = ref.watch(firebaseProvider).currentUser?.displayName;
    log(displayName.toString());
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(displayName ?? "",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        )),
                Konstant.sizedBoxHeight12,
                Text(ref.watch(firebaseProvider).currentUser!.email ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        )),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: const Text('Profile'),
            onTap: () {
              // Update the state of the app.
              // ...
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
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text('Settings'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outlined),
            title: const Text('Help'),
            onTap: () {
              // Update the state of the app.
              // ...
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

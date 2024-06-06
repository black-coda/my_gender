import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final photoUrl = ref.watch(firebaseProvider).currentUser?.photoURL;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),

        children: [
           CircleAvatar(
            radius: 50,
            backgroundImage: CachedNetworkImageProvider(photoUrl ?? 'https://img.freepik.com/free-vector/bangkok-thailand-may-12-2023-caricature-tiger-woods-smilin_1308-133923.jpg?t=st=1717615950~exp=1717619550~hmac=08f597779f75aa09ed965fc3d5156e3b2d65ac52a2c3a72df49315b8b860c2f3&w=826'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Edit Profile'),
            onTap: () {
              // TODO: Implement edit profile functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            onTap: () {
              // TODO: Implement change password functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification Settings'),
            onTap: () {
              // TODO: Implement notification settings functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // TODO: Implement logout functionality
            },
          ),
        ],
      ),
    );
  }
}

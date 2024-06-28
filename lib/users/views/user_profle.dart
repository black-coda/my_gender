import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gender/auth/controllers/auth_state_provider.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';
import 'package:my_gender/utils/constants/konstant.dart';
import 'package:my_gender/utils/image_picker_method.dart';

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
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CircleAvatar(
            radius: 80,
            foregroundImage: CachedNetworkImageProvider(
              photoUrl ??
                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
            ),
          ),
          Konstant.sizedBoxHeight16,
          const Divider(),
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

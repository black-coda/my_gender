import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';
import 'package:my_gender/auth/models/user_info/models/user_dto.dart';
import 'package:my_gender/users/backend/user_profile_backend.dart';
import 'package:my_gender/utils/constants/konstant.dart';
import 'package:my_gender/utils/form/dynamic_form.dart';
import 'package:my_gender/utils/image_picker_method.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  late TextEditingController _displayNameController;
  late TextEditingController _emailController;
  late TextEditingController _dobController;

  late FocusNode _displayNameFocusNode;
  late FocusNode _dobFocusNode;
  late FocusNode emailFocusNode;
  final AuthValidators authValidators = AuthValidators();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _displayNameFocusNode = FocusNode();
    _dobFocusNode = FocusNode();
    emailFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final email = ref.read(firebaseProvider).currentUser?.email;
    final userData = ref.watch(getUserDataProvider).asData?.value;
    final displayName = userData?.displayName;
    final displayName2 = ref.read(firebaseProvider).currentUser?.displayName;
    final dob = userData?.dob;

    _displayNameController =
        TextEditingController(text: displayName ?? displayName2);
    _emailController = TextEditingController(text: email);
    _dobController = TextEditingController(text: dob);
  }

  @override
  void dispose() {
    _displayNameFocusNode.dispose();
    _dobFocusNode.dispose();
    emailFocusNode.dispose();
    _displayNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoUrl = ref.read(firebaseProvider).currentUser?.photoURL;

    // Uint8List? imageBytes;

    void selectImage() async {
      final Uint8List img = await pickImage(ImageSource.gallery);

      ref.read(photoUrlProvider.notifier).state = img;
    }

    final userData = ref.watch(getUserDataProvider);

    final imageBytes = ref.watch(photoUrlProvider);

    return userData.when(
      data: (UserProfileDTO? userProfileData) {
        log("User Profile Data: $userProfileData", name: "EditProfileView");
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        imageBytes == null
                            ? CircleAvatar(
                                radius: 80,
                                foregroundImage: CachedNetworkImageProvider(
                                    photoUrl ??
                                        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                              )
                            : CircleAvatar(
                                radius: 80,
                                backgroundImage: MemoryImage(imageBytes)),
                        Positioned(
                          bottom: -10,
                          left: 100,
                          child: IconButton(
                              onPressed: selectImage,
                              icon: Icon(
                                Icons.add_a_photo_rounded,
                                color: Theme.of(context).colorScheme.secondary,
                              )),
                        ),
                      ],
                    ),
                    Konstant.sizedBoxHeight16,
                    Konstant.sizedBoxHeight16,
                    DynamicInputWidget(
                      isNonPasswordField: true,
                      validator: authValidators.emailValidator,
                      controller: _emailController,
                      obscureText: false,
                      focusNode: emailFocusNode,
                      prefIcon: const Icon(Icons.email_rounded),
                      labelText: "Email",
                      textInputAction: TextInputAction.next,
                      enabled: false,
                    ),
                    Konstant.sizedBoxHeight16,
                    DynamicInputWidget(
                        isNonPasswordField: true,
                        controller: _displayNameController,
                        obscureText: false,
                        focusNode: _displayNameFocusNode,
                        prefIcon: const Icon(Icons.person_outline_sharp),
                        labelText: "Display Name",
                        textInputAction: TextInputAction.next),
                    const SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(userProfileBackendProvider)
                              .updateUserProfile(
                                UserProfileDTO(
                                  displayName: _displayNameController.text,
                                  email: _emailController.text,
                                  dob: _dobController.text,
                                  photoUrl: photoUrl!,
                                ),
                              )
                              .then((value) {
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile Updated Successfully'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile Update Failed'),
                                ),
                              );
                            }
                          });
                        }
                      },
                      icon: const Icon(Icons.save_rounded),
                      label: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}

final photoUrlProvider = StateProvider<Uint8List?>((ref) {
  return null;
});

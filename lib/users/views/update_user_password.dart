import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/users/backend/user_profile_backend.dart';
import 'package:my_gender/utils/constants/konstant.dart';
import 'package:my_gender/utils/form/dynamic_form.dart';

class UpdateUserPassword extends ConsumerStatefulWidget {
  const UpdateUserPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateUserPasswordState();
}

class _UpdateUserPasswordState extends ConsumerState<UpdateUserPassword> {
  final _formKey = GlobalKey<FormState>();

  final AuthValidators authValidators = AuthValidators();

  bool obscureText = false;

  // controllers

  late TextEditingController passwordController;

  // create focus nodes

  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();

    passwordController = TextEditingController();

    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    // controller

    passwordController.dispose();

    // Focus node

    passwordFocusNode.dispose();
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Password"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DynamicInputWidget(
                    isNonPasswordField: false,
                    toggleObscureText: toggleObscureText,
                    validator: authValidators.passwordWordValidator,
                    controller: passwordController,
                    obscureText: obscureText,
                    focusNode: passwordFocusNode,
                    prefIcon: const Icon(Icons.key),
                    labelText: "Enter new password",
                    textInputAction: TextInputAction.done,
                  ),
                  Konstant.sizedBoxHeight16,
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final newPassword = passwordController.text;
                        final isUpdated = await ref
                            .read(userProfileBackendProvider)
                            .updateUserPassword(newPassword: newPassword);
                        if (isUpdated) {
                          final bar = ScaffoldMessenger.of(context);
                          bar.showSnackBar(
                            const SnackBar(
                              content: Text('Your password has been updated!'),
                            ),
                          );
                        } else {
                          final bar = ScaffoldMessenger.of(context);
                          bar.showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'An error occurred while updating your password!'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("Update Password"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

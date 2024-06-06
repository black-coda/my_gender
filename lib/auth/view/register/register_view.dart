import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/auth/controllers/auth_state_provider.dart';
import 'package:my_gender/auth/models/user_info/models/user_dto.dart';
import 'package:my_gender/auth/view/login/divider.dart';
import 'package:my_gender/auth/view/login/google_button.dart';
import 'package:my_gender/auth/view/login/login_view.dart';
import 'package:my_gender/utils/constants/app_colors.dart';
import 'package:my_gender/utils/constants/konstant.dart';
import 'package:my_gender/utils/constants/strings.dart';
import 'package:my_gender/utils/form/dynamic_form.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final AuthValidators authValidators = AuthValidators();

  bool obscureText = false;

  // controllers

  late TextEditingController emailController;
  late TextEditingController passwordController;

  // create focus nodes

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();

    passwordController = TextEditingController();

    emailFocusNode = FocusNode();

    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    // controller
    emailController.dispose();
    passwordController.dispose();

    // Focus node
    emailFocusNode.dispose();
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
        title: Text(Strings.appName,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Text(Strings.createAccount,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontSize: 28)),
                Text(Strings.welcome,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 20, color: const Color(0xff7C7C7C))),
                const DividerWithMargin(),
                DynamicInputWidget(
                  isNonPasswordField: true,
                  controller: emailController,
                  obscureText: false,
                  focusNode: emailFocusNode,
                  prefIcon: const Icon(Icons.email_rounded),
                  labelText: "Email",
                  textInputAction: TextInputAction.next,
                  validator: authValidators.emailValidator,
                ),
                Konstant.sizedBoxHeight16,
                DynamicInputWidget(
                  isNonPasswordField: false,
                  controller: passwordController,
                  obscureText: obscureText,
                  focusNode: passwordFocusNode,
                  prefIcon: const Icon(Icons.lock_rounded),
                  labelText: "Password",
                  textInputAction: TextInputAction.done,
                  toggleObscureText: toggleObscureText,
                  validator: authValidators.passwordWordValidator,
                ),
                Konstant.sizedBoxHeight12,
                Text(
                  Strings.logIntoYourAccount,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(height: 1.5),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final email = emailController.text;
                      final password = passwordController.text;

                      final userDTO = UserDTO(email: email, password: password);
                      ref
                          .read(authStateProvider.notifier)
                          .signUpWithEmailAndPassword(userDTO);
                    }
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.loginButtonColor,
                      foregroundColor: AppColors.loginButtonTextColor,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: const GButton(),
                ),
                const DividerWithMargin(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginView()));
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(color: AppColors.facebookColor),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

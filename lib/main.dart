import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';
import 'package:my_gender/firebase_options.dart';
import 'package:my_gender/onboard/screens/onboard_entry.dart';

import 'app/views/main_app.dart';
import 'auth/controllers/is_loading_provider.dart';
import 'auth/controllers/is_logged_in_provider.dart';
import 'auth/view/login/login_view.dart';
import 'notification/service/notification_service.dart';
import 'utils/loading/loading_screen_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService().init();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // calculate widget to show
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.pinkAccent,
        ),
        colorSchemeSeed: Colors.pink,
      ),

      //     ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          // install the loading screen
          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreenWidget.instance().show(
                  context: context,
                );
              } else {
                LoadingScreenWidget.instance().hide();
              }
            },
          );
          final authChanges = ref.watch(authChangesStreamProvider);
          // install the loading screen
          return authChanges.when(
            data: (data) {
              // final userId = ref.watch()
              return data == null ? const OnboardingScreen() : const MainView();
            },
            error: (error, stackTrace) => Center(
              child: Text("Error ${error.toString()}"),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

final authChangesStreamProvider = StreamProvider<User?>((ref) {
  final fireAuth = ref.watch(firebaseProvider);
  return fireAuth.authStateChanges();
});

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';
import 'package:my_gender/firebase_options.dart';

import 'app/views/main_app.dart';
import 'auth/controllers/is_loading_provider.dart';
import 'auth/controllers/is_logged_in_provider.dart';
import 'auth/view/login/login_view.dart';
import 'utils/loading/loading_screen_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        // scaffoldBackgroundColor: ,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.pinkAccent,
        ),
        // primarySwatch: Colors.blueGrey,

        colorSchemeSeed: Colors.pink,
        // colorScheme: const ColorScheme.dark(
        //     primary: Colors.pink, secondary: Colors.pinkAccent),
        // colorScheme: ColorScheme.fromSwatch(
        //     primarySwatch: Colors.pink, brightness: Brightness.light),
      ),

      //     ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          final authChanges = ref.watch(authChangesStreamProvider);
          // install the loading screen
          return authChanges.when(
            data: (data) {
              return data == null ? const LoginView() : const MainView();
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

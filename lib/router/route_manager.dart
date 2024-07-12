import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gender/app/views/main_app.dart';
import 'package:my_gender/auth/controllers/is_logged_in_provider.dart';
import 'package:my_gender/auth/view/login/login_view.dart';
import 'package:my_gender/onboard/screens/onboard_entry.dart';
import 'package:my_gender/utils/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final authState = ref.watch(isLoggedInProvider);
    return GoRouter(
      redirect: (context, state) async {
        final SharedPreferences preferences = await SharedPreferences.getInstance();

        final bool ? firstTime = preferences.getBool(Strings.firstTimeKey);
        if ( firstTime == null || !firstTime ) {
          return RouteManager.onboardingRoute;
        }
        
        final loggedIn = authState;
        final isLoginRoute = state.path == RouteManager.loginRoute;

        if (!loggedIn && !isLoginRoute) return RouteManager.loginRoute;
        if (loggedIn && isLoginRoute) return RouteManager.dashboardRoute;
        if (loggedIn) return RouteManager.dashboardRoute;
        return null;
      },
      initialLocation: RouteManager.onboardingRoute,
      routes: [
        GoRoute(
          path: RouteManager.loginRoute,
          name: RouteManager.loginView,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: RouteManager.dashboardRoute,
          name: RouteManager.dashboardView,
          builder: (context, state) => const MainView(),
        ),
        GoRoute(
          path: RouteManager.onboardingRoute,
          name: RouteManager.onboardingView,
          builder: (context, state) {
            return const OnboardingScreen();
          },
        ),
      ],
    );
  },
);

class RouteManager {
  //! Onboarding Routes
  static const onboardingRoute = '/onboarding';
  static const onboardingView = "onboarding";

  //! Authentication Routes
  static const loginRoute = '/login';
  static const loginView = "login";
  static const logoutRoute = '/logout';
  static const logoutView = "logout";
  static const registerRoute = '/register';
  static const registerView = "register";
  static const forgotPasswordRoute = '/forgot-password';
  static const forgotPasswordView = "forgot-password";

  //! Non Authentication Routes
  static const dashboardRoute = '/dashboard';
  static const dashboardView = "dashboard";
  static const tipsRoute = '/tips';
  static const tipsView = "tips";
  static const botRoute = '/bot';
  static const botView = "bot";
  static const profileRoute = '/profile';
  static const profileView = "profile";
  static const settingsRoute = '/settings';
  static const settingsView = "settings";
  static const aboutRoute = '/about';
  static const aboutView = "about";
}

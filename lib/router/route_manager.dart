import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gender/app/views/main_app.dart';
import 'package:my_gender/auth/controllers/auth_state_provider.dart';
import 'package:my_gender/auth/models/auth_result.dart';
import 'package:my_gender/auth/view/login/login_view.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final authState = ref.watch(authStateProvider);
    return GoRouter(
      redirect: (context, state) {
        final loggedIn = authState.result == AuthResult.success;
        final isLoginRoute = state.path == RouteManager.loginRoute;

        if (!loggedIn && !isLoginRoute) return RouteManager.loginRoute;
        if (loggedIn && isLoginRoute) return RouteManager.dashboardRoute;

        return null;
      },
      initialLocation: RouteManager.onboardingRoute,
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const MainView(),
        ),
        GoRoute(path: RouteManager.onboardingRoute, builder: (context, state) {
          return const OnboardView();
        }),
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

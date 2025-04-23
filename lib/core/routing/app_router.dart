import 'package:go_router/go_router.dart';
import 'package:video_desktop_saver/features/auth/presentation/auth_screen.dart';
import 'package:video_desktop_saver/features/home/presentation/home_screen.dart';
import 'package:video_desktop_saver/features/keyboard/presentation/keyboard_screen.dart';
import 'package:video_desktop_saver/features/splash/splash_screen.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: SplashScreen.routeName,
    routes: [
      GoRoute(
        path: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: KeyboardScreen.routeName,
        builder: (context, state) => const KeyboardScreen(),
      ),
      GoRoute(
        path: AuthScreen.routeName,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: HomeScreen.routeName,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}

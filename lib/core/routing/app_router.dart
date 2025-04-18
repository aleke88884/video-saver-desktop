import 'package:go_router/go_router.dart';
import 'package:video_desktop_saver/features/auth/presentation/auth_screen.dart';
import 'package:video_desktop_saver/features/home/presentation/home_screen.dart';
import 'package:video_desktop_saver/features/splash/splash_screen.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      observers: [],
      initialLocation: SplashScreen.routeName,
      routes: [
        GoRoute(
          path: SplashScreen.routeName,
          builder: (context, state) => const SplashScreen(),
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
  }
}

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../state/auth_notifier.dart';
import '../ui/pages/signin_page.dart';
import '../ui/pages/home_page.dart';

class AppRouter {
  // On expose une méthode pour créer la config à partir de l'état d’auth.
  static GoRouter create(AuthNotifier auth) {
    return GoRouter(
      initialLocation: '/signin',
      refreshListenable: auth, // <-- déclenche redirect quand l’auth change
      redirect: (context, state) {
        final signedIn = auth.isSignedIn;
        final goingToSignIn = state.matchedLocation == '/signin';
        if (!signedIn && !goingToSignIn) return '/signin';
        if (signedIn && goingToSignIn) return '/home';
        return null;
      },
      routes: [
        GoRoute(path: '/signin', builder: (_, __) => const SignInPage()),
        GoRoute(path: '/home', builder: (_, __) => const HomePage()),
      ],
    );
  }
}

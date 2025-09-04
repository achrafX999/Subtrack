import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router/app_router.dart';
import 'state/auth_notifier.dart';

class SubTrackApp extends StatelessWidget {
  const SubTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthNotifier(),
      child: Builder(
        builder: (context) {
          final auth = context.read<AuthNotifier>();
          // Si tu utilises la version "statique init", fais:
          // AppRouter.init(auth);
          // return MaterialApp.router(routerConfig: AppRouter.config, ...);

          return MaterialApp.router(
            title: 'SubTrack',
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.create(auth), // <-- clé : passe l’auth ici
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5)),
              useMaterial3: true,
            ),
          );
        },
      ),
    );
  }
}

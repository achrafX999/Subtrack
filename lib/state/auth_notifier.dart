import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthNotifier extends ChangeNotifier {
  User? _user;
  late final StreamSubscription<User?> _sub;

  AuthNotifier() {
    _sub = FirebaseAuth.instance.authStateChanges().listen((u) {
      _user = u;
      notifyListeners();
    });
  }

  User? get user => _user;
  bool get isSignedIn => _user != null;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

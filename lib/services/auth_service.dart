import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _google = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    // Ouvre le sélecteur de compte Google
    final account = await _google.signIn();
    if (account == null) throw Exception('Connexion annulée');

    // Récupère les tokens et crée l’identifiant Firebase
    final auth = await account.authentication;
    final cred = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    return _auth.signInWithCredential(cred);
  }

  Future<void> signOut() async {
    await _google.signOut();
    await _auth.signOut();
  }

  Stream<User?> get userStream => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
}

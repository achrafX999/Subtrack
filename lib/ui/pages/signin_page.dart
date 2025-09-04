import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _auth = AuthService();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    try {
      final cred = await _auth.signInWithGoogle();
      final mail = cred.user?.email ?? 'inconnu';
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connecté: $mail')),
      );
      // TODO: naviguer vers Home si tu as un router (context.go('/home'))
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton.icon(
          onPressed: _loading ? null : _login,
          icon: _loading ? const SizedBox(
            width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2),
          ) : const Icon(Icons.login),
          label: Text(_loading ? 'Connexion...' : 'Se connecter avec Google'),
        ),
      ),
    );
  }
}

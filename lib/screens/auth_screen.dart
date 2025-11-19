import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jajanku_pos/providers/authentication_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('🔑 Supabase Auth (Provider)')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            if (authProvider.isLoading)
              const CircularProgressIndicator()
            else
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () => authProvider.signUp(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    ),
                    child: const Text('Sign Up'),
                  ),
                  ElevatedButton(
                    onPressed: () => authProvider.signIn(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    ),
                    child: const Text('Sign In'),
                  ),
                  ElevatedButton(
                    onPressed: authProvider.signOut,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Text(
              authProvider.message ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

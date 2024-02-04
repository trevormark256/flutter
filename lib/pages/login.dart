// ignore_for_file: use_build_context_synchronously

import 'package:dartprac/auth.dart';
import 'package:dartprac/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInScreen extends ConsumerWidget {
  static const routeName = "/signin";
  SignInScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 255, 88, 76),
      textColor: const Color.fromARGB(255, 255, 255, 255),
      fontSize: 16.0,
    );
  }

  Future<void> _signIn(BuildContext context, WidgetRef ref) async {
    try {
      final authData = AuthData(
        email: emailController.text,
        password: passwordController.text,
      );

      print("Before signInProvider call"); // Debug print
      await ref.read(signInProvider(authData).future);
      print("After signInProvider call"); // Debug print

      // Navigate after successful sign-in
    } catch (e) {
      print("Error during sign-in: $e"); // Debug print
      errorToast("$e");
    }
  }

  void errorToast(String message) {
    // Your existing errorToast implementation
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth with Riverpod'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                obscureText: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: 'Email'),
              ),
              SizedBox(
                height: 26,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: 'Password'),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    errorToast("fields are empty");
                  } else {
                    await _signIn(context, ref);
                  }
                },
                child: const Text('Sign In'),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("already have an account"),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      SignupScreen.routeName,
                    ),
                    child: const Text(" signup"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

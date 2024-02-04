import 'package:dartprac/auth.dart';
import 'package:dartprac/pages/home.dart';
import 'package:dartprac/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends ConsumerWidget {
  static const routeName = "/signup";
  SignupScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  void errorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 206, 0, 0),
      textColor: Color.fromARGB(255, 0, 0, 0),
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final signInState =
        ref.watch(signInProvider(AuthData(email: "", password: "")));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth with Riverpod'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: 'username'),
              ),
              SizedBox(
                height: 19,
              ),
              TextField(
                controller: emailController,
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
                height: 19,
              ),
              TextField(
                controller: confirmpasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: 'confirm Password'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      usernameController.text.isEmpty ||
                      confirmpasswordController.text.isEmpty) {
                    return errorToast("Fields are empty");
                  }

                  if (passwordController.text !=
                      confirmpasswordController.text) {
                    return errorToast("Passwords don't match");
                  }

                  try {
                    // Show a loading indicator
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircularProgressIndicator(),
                            Text("Signing up..."),
                          ],
                        ),
                      ),
                    );

                    final authData = AuthData(
                      email: emailController.text,
                      password: passwordController.text,
                      username: usernameController.text,
                    );

                    // Use signUpProvider for signing up
                    await ref.read(signUpProvider(authData).future);

                    // Use signInProvider for signing in
                    await ref.read(signInProvider(authData).future);

                    // Clear text controllers
                    usernameController.clear();
                    emailController.clear();
                    passwordController.clear();
                    confirmpasswordController.clear();

                    // Hide the loading indicator
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    // Navigate to Home screen
                    Navigator.popAndPushNamed(context, Home.routeName);
                  } catch (e) {
                    // Hide the loading indicator
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    return errorToast("$e");
                  }
                },
                child: const Text('Sign Up'),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("already have an account"),
                  TextButton(
                      onPressed: () => Navigator.popAndPushNamed(
                          context, SignInScreen.routeName),
                      child: Text("signin"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

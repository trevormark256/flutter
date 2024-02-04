import 'package:dartprac/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  static const routeName = "/home";
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          authState.when(
            loading: () => CircularProgressIndicator(),
            error: (error, stackTrace) => Text('Error: $error'),
            data: (user) {
              if (user != null) {
                return Column(
                  children: [
                    Text("Welcome, ${user.displayName ?? user.email}!"),
                    Text("Email: ${user.email}"),
                    ElevatedButton(
                      onPressed: () async {
                        final signout = await ref.read(signOutProvider.future);
                        signout();
                        Navigator.pushReplacementNamed(context, '/signin');
                      },
                      child: Text("signout"),
                    ),
                  ],
                );
              } else {
                // Handle the case where the user is null
                return const Text('User is null');
              }
            },
          ),
        ],
      ),
    );
  }
}

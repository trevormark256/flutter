import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider((ref) => FirebaseAuth.instance);

final authStateProvider = FutureProvider.autoDispose<User?>((ref) async {
  final auth = ref.read(authProvider);
  return auth.currentUser;
});
final signUpProvider =
    FutureProvider.autoDispose.family<User?, AuthData>((ref, authData) async {
  final auth = ref.read(authProvider);
  final firestore = FirebaseFirestore.instance;

  try {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: authData.email,
      password: authData.password,
    );

    final user = userCredential.user;

    // Update Firestore with user information
    await firestore.collection('my users').doc(user?.uid).set({
      'email': user?.email,
      'username': authData.username, // Add
      // Add other fields as needed
    });

    return user;
  } catch (e) {
    print('Error signing up: $e');
    return null;
  }
});

// Reusing the signInProvider for signing in
final signInProvider =
    FutureProvider.autoDispose.family<User?, AuthData>((ref, authData) async {
  final auth = ref.read(authProvider);
  try {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: authData.email,
      password: authData.password,
    );

    return userCredential.user;
  } catch (e) {
    print('Error signing in: $e');
    return null;
  }
});

final signOutProvider = FutureProvider.autoDispose<void Function()>(
  (ref) async {
    final auth = ref.read(authProvider);
    return () async {
      await auth.signOut();
    };
  },
);

class AuthData {
  final String email;
  final String password;
  final String? username;

  AuthData({
    required this.email,
    required this.password,
    this.username,
  });
}

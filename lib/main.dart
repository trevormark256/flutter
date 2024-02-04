import 'package:dartprac/firebase_options.dart';
import 'package:dartprac/pages/auth.dart';
import 'package:dartprac/pages/login.dart';
import 'package:dartprac/pages/signup.dart';
import 'package:dartprac/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final darkmod = ref.watch(darkmode);

    return MaterialApp(
      darkTheme: ThemeData.dark(),
      // themeMode: darkmod ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const AuthCheckScreen(),
      routes: {
        SignupScreen.routeName: (context) => SignupScreen(),
        SignInScreen.routeName: (context) => SignInScreen(),
        Home.routeName: (context) => const Home(),
      },
    );
  }
}

// final darkmode = StateNotifierProvider.autoDispose<Modenotifier, bool>(
//   (ref) => Modenotifier(),
// );

// class Modenotifier extends StateNotifier<bool> {
//   Modenotifier() : super(false);

//   void toggleswitch() {
//     state = !state;
//   }
// }

// final counter =
//     StateNotifierProvider<Countnotifier, int>((ref) => Countnotifier());

// class Countnotifier extends StateNotifier<int> {
//   Countnotifier() : super(0);

//   bool _initialized = false;

//   Future<void> init() async {
//     if (!_initialized) {
//       await loadFromPreferences();
//       _initialized = true;
//     }
//   }

//   Future<void> saveToPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('count', state);
//   }

//   Future<void> loadFromPreferences() async {
//     const CircularProgressIndicator.adaptive();
//     final prefs = await SharedPreferences.getInstance();
//     state = prefs.getInt('count') ?? 0;
//   }

//   increase() {
//     state = state + 1;
//     saveToPreferences();
//   }

//   decrease() {
//     state = state - 1;
//     saveToPreferences();
//   }
// }

// class Home extends ConsumerWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final value = ref.watch(darkmode);
//     final count = ref.watch(counter);
//     final countNotifier = ref.read(counter.notifier);
//     countNotifier.init();
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Expanded(
//             child: SwitchListTile.adaptive(
//               title: const Text("switch"),
//               thumbIcon: const MaterialStatePropertyAll(Icon(
//                 Icons.bedtime_sharp,
//                 color: Colors.black,
//               )),
//               contentPadding: const EdgeInsets.all(4),
//               trackColor:
//                   MaterialStatePropertyAll(value ? Colors.green : Colors.white),
//               activeColor: const Color.fromARGB(255, 60, 255, 0),
//               value: value,
//               onChanged: (value) => ref.read(darkmode.notifier).toggleswitch(),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Text("$count"),
//           TextButton(
//             style: const ButtonStyle(
//               backgroundColor: MaterialStatePropertyAll(Colors.green),
//             ),
//             onPressed: () => ref.read(counter.notifier).increase(),
//             child: const Text("increase"),
//           ),
//           TextButton(
//             onPressed: () => ref.invalidate(counter),
//             child: const Text("reset"),
//           ),
//           TextButton(
//             style: const ButtonStyle(
//               backgroundColor:
//                   MaterialStatePropertyAll(Color.fromARGB(255, 255, 85, 6)),
//             ),
//             onPressed: () => ref.read(counter.notifier).decrease(),
//             child: const Text("decrease"),
//           ),
//         ],
//       ),
//     );
//   }
//}

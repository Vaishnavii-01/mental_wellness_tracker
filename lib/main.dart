import 'package:mental_wellness_tracker/models/board.dart';
import 'package:mental_wellness_tracker/pages/mood_cart.dart';
import 'package:mental_wellness_tracker/pages/intro_page.dart';
import 'package:mental_wellness_tracker/pages/login_page.dart';
import 'package:mental_wellness_tracker/pages/signup_page.dart';
import 'package:mental_wellness_tracker/pages/mood_board.dart';
import 'package:mental_wellness_tracker/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:mental_wellness_tracker/consts.dart';
import 'package:mental_wellness_tracker/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(ChangeNotifierProvider(
    create: (context) => Board(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      home: const IntroPage(),
      theme: lightmode,
      routes: {
        'intro_pages': (context) => const IntroPage(),
        '/login_page': (context) => const LoginPage(), // Existing Login Page
        '/signup_page': (context) => const SignupPage(), // Existing Signup Page
        '/mood_board': (context) => const MoodBoard(),
        '/chat_page': (context) => const HomePage(),
        '/mood_cart': (context) => const MoodCart(),
      },
    );
  }
}
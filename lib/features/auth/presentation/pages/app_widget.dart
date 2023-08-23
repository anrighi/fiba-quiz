import 'package:flutter/material.dart';
import 'package:fiba_quiz/features/auth/presentation/pages/admin_page.dart';
import 'package:fiba_quiz/features/auth/presentation/pages/intro_page.dart';
import 'package:fiba_quiz/features/auth/presentation/pages/sign_in_page.dart';
import 'package:fiba_quiz/features/auth/presentation/pages/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppWidget extends StatefulWidget {
  static Map<String, Object> loggedUser = {};
  static bool isLogin = false;
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser != null
          ? const AdminPage()
          : const IntroPage(),
      routes: {
        IntroPage.id: (context) => const IntroPage(),
        SignUpPage.id: (context) => SignUpPage(),
        SignInPage.id: (context) => SignInPage(),
        AdminPage.id: (context) => const AdminPage(),
      },
    );
  }
}

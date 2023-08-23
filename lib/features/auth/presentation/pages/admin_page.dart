import 'package:fiba_quiz/features/auth/presentation/pages/sign_in_page.dart';
import 'package:fiba_quiz/features/auth/presentation/validator/auth_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminPage extends StatefulWidget {
  static const String id = "profilo";
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.abc,
              color: Colors.transparent,
            ),
            const Text("Profilo"),
            TextButton(
              onPressed: logOut,
              child: const Icon(
                Icons.logout_sharp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              TextFormField(
                initialValue: FirebaseAuth.instance.currentUser?.email,
                readOnly: true,
                validator: AuthValidator.isEmailValid,
                decoration: const InputDecoration(
                  hintText: "indirizzo email",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, SignInPage.id);
  }
}

import 'package:fiba_quiz/features/auth/presentation/components/buttons.dart';
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
  TextEditingController nameController = TextEditingController(
      text: FirebaseAuth.instance.currentUser?.displayName);

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
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "nome",
                ),
              ),
              TextFormField(
                initialValue: FirebaseAuth.instance.currentUser?.email,
                readOnly: true,
                validator: AuthValidator.isEmailValid,
                decoration: const InputDecoration(
                  hintText: "indirizzo email",
                ),
              ),
              const SizedBox(height: 120),
              PrimaryButton(
                text: "Salva",
                onPressed: saveFirebaseData,
              )
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

  void saveFirebaseData() async {
    if (FirebaseAuth.instance.currentUser?.displayName != nameController.text) {
      FirebaseAuth.instance.currentUser?.updateDisplayName(nameController.text);
    }
  }
}

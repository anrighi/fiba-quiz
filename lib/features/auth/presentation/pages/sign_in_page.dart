import 'package:flutter/material.dart';
import 'package:fiba_quiz/features/auth/presentation/pages/admin_page.dart';
import 'package:fiba_quiz/features/auth/presentation/pages/app_widget.dart';
import 'package:fiba_quiz/features/auth/presentation/validator/auth_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/buttons.dart';

class SignInPage extends StatefulWidget {
  static const String id = "login";
  String _signinError = "";

  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _signInGlobalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordSee = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              width: 100,
              height: 100,
            ),
            const Center(
              child: Text(
                "Accedi per continuare",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              width: 100,
              height: 100,
            ),
            /*Column(
              children: const [
                MyButton(
                  iconUrl: 'assets/images/ic_google.png',
                  text: "Log in with Google",
                ),
                SizedBox(height: 20),
                MyButton(
                  iconUrl: 'assets/images/ic_facebook.png',
                  text: "Log in with Google",
                ),
                SizedBox(height: 20),
                Text(
                  "Or",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            */
            Form(
              key: _signInGlobalKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: AuthValidator.isEmailValid,
                    decoration:
                        const InputDecoration(hintText: "indirizzo email"),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: passwordController,
                    obscureText: passwordSee,
                    validator: AuthValidator.isPasswordValid,
                    decoration: InputDecoration(
                      hintText: "password",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          passwordSee = !passwordSee;
                          setState(() {});
                        },
                        child: Icon(
                          passwordSee
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            Text(
              widget._signinError,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget._signinError == 'Login avvenuto con successo'
                    ? const Color(0xFF00B800)
                    : const Color(0xFFE60000),
                letterSpacing: 0.5,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                MyButtonTwo(text: "Accedi", onPressed: signIn),
                const SizedBox(height: 30),
                const Text(
                  "Hai dimenticato la password?",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xFF265AE8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    String signinError = "";

    setState(() {
      widget._signinError = signinError;
    });

    if (_signInGlobalKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          signinError = "Email non trovata";
        } else if (e.code == 'wrong-password') {
          signinError = "Password errata";
        }
      }

      if (signinError.isNotEmpty) {
        setState(() {
          widget._signinError = signinError;
        });
      } else {
        setState(() {
          widget._signinError = "Login avvenuto con successo";
        });

        AppWidget.isLogin = true;
        AppWidget.loggedUser["email"] = emailController.text.trim();
        AppWidget.loggedUser["password"] = passwordController.text.trim();

        Navigator.pushNamed(context, AdminPage.id);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

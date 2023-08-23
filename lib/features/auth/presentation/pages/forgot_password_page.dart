import 'package:flutter/material.dart';
import 'package:fiba_quiz/features/auth/presentation/components/buttons.dart';
import 'package:fiba_quiz/features/auth/presentation/validator/auth_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String id = "password-dimenticata";
  String _signupError = "";

  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _signUpGlobalKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  bool passwordSee = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _signUpGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.chevron_left,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "Inserisci il tuo indirizzo email",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 55),
                Column(
                  children: [
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: emailController,
                      validator: AuthValidator.isEmailValid,
                      decoration: const InputDecoration(
                        hintText: "indirizzo email",
                      ),
                    ),
                    const SizedBox(height: 120),
                    PrimaryButton(
                      text: "Invia email",
                      onPressed: signUpButton,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      widget._signupError,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            widget._signupError == 'Email inviata con successo'
                                ? Color(0xFF00B800)
                                : Color(0xFFE60000),
                        letterSpacing: 0.5,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUpButton() async {
    String signupError = "";

    setState(() {
      widget._signupError = signupError;
    });

    if (_signUpGlobalKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        signupError = 'Errore sconosciuto: contattare l\'assistenza.';
      }

      if (signupError.isNotEmpty) {
        setState(() {
          widget._signupError = signupError;
        });
      } else {
        setState(() {
          widget._signupError = "Email inviata con successo";
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}

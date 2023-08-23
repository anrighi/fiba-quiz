import 'package:flutter/material.dart';
import 'package:fiba_quiz/features/auth/presentation/components/buttons.dart';
import 'package:fiba_quiz/features/auth/presentation/validator/auth_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  static const String id = "registrati";
  String _signupError = "";

  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _signUpGlobalKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                      "Inserisci i tuoi dati",
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
                    const SizedBox(height: 40),
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
                    const SizedBox(height: 120),
                    MyButtonTwo(
                      text: "Continua",
                      onPressed: signUpButton,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      widget._signupError,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget._signupError ==
                                'Registrazione avvenuta con successo'
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
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          signupError = 'La password è troppo debole.';
        } else if (e.code == 'email-already-in-use') {
          signupError = 'L\'account esiste già per quell\'indirizzo email.';
        }
      } catch (e) {
        signupError = 'Errore sconosciuto: contattare l\'assistenza.';
      }

      if (signupError.isNotEmpty) {
        setState(() {
          widget._signupError = signupError;
        });
      } else {
        setState(() {
          widget._signupError = "Registrazione avvenuta con successo";
        });
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

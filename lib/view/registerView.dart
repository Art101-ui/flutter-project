import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                      ),
                    ),
                    TextField(
                      controller: password,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                      ),
                    ),
                    TextButton(
                      child: const Text('Register'),
                      onPressed: () async {
                        final _email = email.text;
                        final _password = password.text;
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _email,
                            password: _password,
                          );
                          print(credential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('Weak password');
                          } else if (e.code == 'email-already-in-use') {
                            print('Email already used');
                          } else if (e.code == 'invalid-email') {
                            print('Invalid Email');
                          }
                        }
                      },
                    ),
                  ],
                );
              default:
                return Container(child: (const Text('Loading...')));
            }
          }),
    );
  }
}

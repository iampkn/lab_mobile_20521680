import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab04/services/auth.dart';
import 'package:flutter/material.dart';

class SignUpButton extends StatefulWidget {
  final String email;
  final String password;
  final GlobalKey<FormState> _formKey;
  const SignUpButton(this.email, this.password, this._formKey, {super.key});

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  final Auth _auth = Auth();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () async {
          if (widget._formKey.currentState!.validate()) {
            try {
              await _auth.register(widget.email.trim(), widget.password.trim());

              _scaffoldMessengerKey.currentState?.showSnackBar(
                  const SnackBar(content: Text('Register success')));
            } catch (e) {
              if (e is FirebaseException) {
                String errorMessage = e.message.toString();

                _scaffoldMessengerKey.currentState?.showSnackBar(
                  SnackBar(content: Text(errorMessage)),
                );
              } else {
                _scaffoldMessengerKey.currentState?.showSnackBar(
                  const SnackBar(content: Text("I don't know :)")),
                );
              }
            }
          }
        },
        child: const Text("Sign up"));
  }
}

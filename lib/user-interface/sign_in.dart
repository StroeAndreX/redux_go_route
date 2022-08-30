import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redux_go_route/redux/actions/auth_actions.dart';
import 'package:redux_go_route/redux/store.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Hello new user"),
              TextButton(
                onPressed: () {
                  store.dispatch(UpdateAuthState());
                },
                child: const Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

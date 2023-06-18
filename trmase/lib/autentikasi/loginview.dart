import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Login_View extends StatefulWidget {
  const Login_View({super.key});

  @override
  State<Login_View> createState() => _Login_ViewState();
}

class _Login_ViewState extends State<Login_View> {
  late final TextEditingController _email;
  late final TextEditingController _pass;

  @override
  void initState() {
    _email = TextEditingController();
    _pass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Smart Door Lock",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.apply(fontWeightDelta: 2)),
            const SizedBox(
              height: 15,
            ),
            Text("Login", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: 340,
              child: TextField(
                controller: _email,
                cursorColor: Theme.of(context).colorScheme.tertiary,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.tertiary)),
                    hintText: "Your email",
                    icon: Icon(Icons.email)),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 340,
              child: TextField(
                obscureText: true,
                controller: _pass,
                cursorColor: Theme.of(context).colorScheme.tertiary,
                decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: "Your Password",
                    icon: Icon(Icons.lock)),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _pass.text;
                try {
                  final usercredentials = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email, password: password);
                  print(usercredentials);
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    if (user.emailVerified) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/mynotes/', (route) => false);
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/verifyemail/', (route) => false);
                    }
                  } else {
                    Text("haduh");
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == "user-not-found") {
                    print("Gak ada");
                  } else {
                    print(e.code);
                  }
                }
              },
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/register/', (route) => false);
                },
                child: Text(
                  "Not Registered yet? register now!",
                  style: Theme.of(context).textTheme.bodyMedium,
                ))
          ],
        ),
      ),
    );
  }
}

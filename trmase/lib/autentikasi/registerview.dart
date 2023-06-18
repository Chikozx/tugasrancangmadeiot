import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trmase/main.dart';

class Register_view extends StatefulWidget {
  const Register_view({super.key});

  @override
  State<Register_view> createState() => _Register_viewState();
}

class _Register_viewState extends State<Register_view> {
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

  int counter = 0;
  void nambah() {
    setState(() {
      counter++;
    });
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
            Text("Register", style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(
              height: 30,
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
                      .createUserWithEmailAndPassword(
                          email: email, password: password);
                  print(usercredentials);
                } on FirebaseAuthException catch (e) {
                  print(e.code);
                }
              },
              child: Text(
                "Register",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login/', (route) => false);
              },
              child: Text(
                'Already have an account? Login Here',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

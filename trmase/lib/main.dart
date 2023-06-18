import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:trmase/autentikasi/loginview.dart';
import 'package:trmase/autentikasi/registerview.dart';
import 'package:trmase/autentikasi/verifyemailview.dart';
import 'package:trmase/halamanutama/mynotes.dart';
import 'package:trmase/halamanutama/dataview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: const HomePage(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 131, 0, 0),
          primary: const Color.fromARGB(255, 71, 7, 7),
          secondary: const Color.fromARGB(255, 247, 230, 196),
          tertiary: const Color.fromARGB(255, 241, 195, 118),
          outlineVariant: const Color.fromARGB(255, 96, 108, 93),
          background: const Color.fromARGB(255, 255, 244, 244)),
      textTheme: GoogleFonts.merriweatherTextTheme().apply(
          displayColor: const Color.fromARGB(255, 241, 195, 118),
          bodyColor: const Color.fromARGB(255, 0, 0, 0)),
    ),
    routes: {
      '/login/': (context) => Login_View(),
      '/register/': (context) => Register_view(),
      '/mynotes/': (context) => MyNotes(),
      '/verifyemail/': (context) => VerifyEmailView(),
      '/dataview/': (context) => DataView()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              final verifiedemail = user?.emailVerified ?? false;
              if (user != null) {
                if (verifiedemail) {
                  print("done");
                } else {
                  print("ure not verivied user, verify first");
                  return VerifyEmailView();
                }
              } else {
                return Login_View();
              }
              return MyNotes();
            default:
              return const RefreshProgressIndicator();
          }
        });
  }
}

AppBar apbar() {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5hR3RaLz__8EJUpFiCGVO4l1RVrqxyGPfEj6cZ4V0Aw&s",
          scale: 2.5,
        ),
        const Text(
          "| MANCHESTER UNITED F.C.",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 223, 27, 31),
    foregroundColor: const Color.fromARGB(255, 250, 246, 0),
  );
}

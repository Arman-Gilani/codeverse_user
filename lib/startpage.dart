import 'package:codeverse_user/authpage.dart';
import 'package:codeverse_user/verifyemail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(snapshot.hasError)
        {
          return Center(
            child: Text(snapshot.error.toString(),
              style: const TextStyle(
                fontFamily: "ComicSansMS3",
                fontWeight: FontWeight.bold,
                wordSpacing: 2.0,
                letterSpacing: 2.0,
              ),
            ),
          );
        }
        else if(snapshot.hasData)
        {
          return const VerifyEmail();
        }
        else
        {
          return const AuthPage();
        }
      },
    ),
  );
}
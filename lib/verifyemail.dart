import 'dart:async';
import 'package:codeverse_user/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {

  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (timer) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: const TextStyle(
              fontFamily: "ComicSansMS3",
              fontWeight: FontWeight.bold,
              wordSpacing: 2.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomePage()
      : Scaffold(

          appBar: AppBar(
            title: const Text(
              "codeVerse",
              style: TextStyle(
                fontFamily: "ComicSansMS3",
                fontWeight: FontWeight.bold,
                wordSpacing: 2.0,
                letterSpacing: 2.0,
              ),
            ),
          ),

          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: const Text(
                        "A verification mail has been sent to your gmail to verify you gmail account. If you don't get mail check your spam folder.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () =>
                            canResendEmail ? sendVerificationEmail() : null,
                            child: const Text(
                              "Resend Email",
                              style: TextStyle(
                                fontFamily: "ComicSansMS3",
                                fontWeight: FontWeight.bold,
                                wordSpacing: 2.0,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () => FirebaseAuth.instance.signOut(),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontFamily: "ComicSansMS3",
                                fontWeight: FontWeight.bold,
                                wordSpacing: 2.0,
                                letterSpacing: 2.0,
                              ),
                            ),
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
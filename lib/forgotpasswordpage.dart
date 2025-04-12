import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _fpformKey=GlobalKey<FormState>();
  final _email=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("codeVerse",
          style: TextStyle(
            fontFamily: "ComicSansMS3",
            fontWeight: FontWeight.bold,
            wordSpacing: 2.0,
            letterSpacing: 2.0,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _fpformKey,
            child: Column(
              children: [

                Lottie.asset(
                  "animation/forgotpassword_animation.json",
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0),
                  child: const Text("To reset password enter your email.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "ComicSansMS3",
                      wordSpacing: 2.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
                  child: TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email:",
                    ),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Email is Required!";
                      }
                      if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
                      {
                        return "Email is not Valid!";
                      }
                      return null;
                    },
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          if(_fpformKey.currentState!.validate())
                          {
                            resetPassword();
                          }
                        },
                        child: const Text("Reset Password",
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

  Future<void> resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("PASSWORD RESET EMAIL SEND.",
            style: TextStyle(
              fontFamily: "ComicSansMS3",
              fontWeight: FontWeight.bold,
              wordSpacing: 2.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException  catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString(),
            style: const TextStyle(
              fontFamily: "ComicSansMS3",
              fontWeight: FontWeight.bold,
              wordSpacing: 2.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
      );
      Navigator.of(context).pop();
    }
  }

}
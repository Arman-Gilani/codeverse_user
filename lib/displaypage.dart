import 'dart:async';
import 'package:codeverse_user/startpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const StartPage(),),
      );
    },);
  }

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

      body: Center(
        child: Lottie.asset(
          "animation/animation1.json",
          height: 300.0,
          width: 300.0,
        ),
      ),

    );
  }
}
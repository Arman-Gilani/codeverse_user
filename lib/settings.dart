import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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

      body: const Center(
        child: Text("settings page!",
          style: TextStyle(
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

// appBar: AppBar(
//   title: const Text(
//     "codeVerse",
//     style: TextStyle(
//       fontFamily: "ComicSansMS3",
//       fontWeight: FontWeight.bold,
//       wordSpacing: 2.0,
//       letterSpacing: 2.0,
//     ),
//   ),
// ),
//
// body: const Center(
//   child: Text(
//     "settings page!",
//     style: TextStyle(
//       fontFamily: "ComicSansMS3",
//       fontWeight: FontWeight.bold,
//       wordSpacing: 2.0,
//       letterSpacing: 2.0,
//     ),
//   ),
// ),
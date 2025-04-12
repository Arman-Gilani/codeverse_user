import 'package:codeverse_user/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FinalUserUpdateData extends StatefulWidget {
  String user_name = "", user_contactno = "", user_imageurl = "";
  FinalUserUpdateData({super.key,required this.user_name,required this.user_contactno,required this.user_imageurl});

  @override
  State<FinalUserUpdateData> createState() => _FinalUserUpdateDataState();
}

class _FinalUserUpdateDataState extends State<FinalUserUpdateData> {
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

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      updateNewUserData();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "UPDATE",
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
          ),
        ),
      ),

    );
  }

  Future<void> updateNewUserData() async {

    DatabaseReference databaseReference=FirebaseDatabase.instance
        .ref("USERS")
        .child(FirebaseAuth.instance.currentUser!.uid);

    await databaseReference.update({
      "user_name": widget.user_name,
      "user_contactno": widget.user_contactno,
      "user_imageurl": widget.user_imageurl,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "PROFILE UPDATED SUCCESSFULLY!",
            style: TextStyle(
              fontFamily: "ComicSansMS3",
              fontWeight: FontWeight.bold,
              wordSpacing: 2.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
      );
      FirebaseAuth.instance.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
    });

  }

}
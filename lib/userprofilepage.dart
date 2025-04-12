import 'dart:async';
import 'package:codeverse_user/usereditprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  Map<dynamic, dynamic> map={},userData={};
  String userUID="";

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

      body: FutureBuilder<Map<dynamic, dynamic>>(
        future: fetchUserData(),
        builder: (context, snapshot) {

          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if(snapshot.hasData){
            userData=snapshot.data!;

            //ui
            return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
                        child: const Text("Profile",
                          style: TextStyle(
                            fontFamily: "ComicSansMS3",
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            wordSpacing: 2.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          color: Colors.white70,
                          child: Column(
                            children: [

                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 65.0,
                                  child: InkWell(
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(userData["user_imageurl"]),
                                      radius: 60.0,
                                    ),
                                    onTap: () {
                                      showDialog(context: context, builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Profile Image",
                                            style: TextStyle(
                                              fontFamily: "ComicSansMS3",
                                              fontWeight: FontWeight.bold,
                                              wordSpacing: 2.0,
                                              letterSpacing: 2.0,
                                            ),
                                          ),
                                          content: Image.network(userData["user_imageurl"]),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Close",
                                                style: TextStyle(
                                                  fontFamily: "ComicSansMS3",
                                                  fontWeight: FontWeight.bold,
                                                  wordSpacing: 2.0,
                                                  letterSpacing: 2.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },);
                                    },
                                  ),
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                                child: Text(userData["user_name"],
                                  style: const TextStyle(
                                    fontFamily: "ComicSansMS3",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    wordSpacing: 2.0,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),

                      Column(
                        children: [

                          //first
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0),
                                    child: const Text("Email",
                                      style: TextStyle(
                                        fontFamily: "ComicSansMS3",
                                        wordSpacing: 2.0,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      color: Colors.white70,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
                                            child: const Icon(Icons.mail_sharp),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
                                            child: Text(userData["user_email"],
                                              style: const TextStyle(
                                                fontFamily: "ComicSansMS3",
                                                fontWeight: FontWeight.bold,
                                                wordSpacing: 2.0,
                                                letterSpacing: 2.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //first

                          //second
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0),
                                    child: const Text("Contact Number",
                                      style: TextStyle(
                                        fontFamily: "ComicSansMS3",
                                        wordSpacing: 2.0,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      color: Colors.white70,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
                                            child: const Icon(Icons.phone),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                            child: Text(userData["user_contactno"],
                                              style: const TextStyle(
                                                fontFamily: "ComicSansMS3",
                                                fontWeight: FontWeight.bold,
                                                wordSpacing: 2.0,
                                                letterSpacing: 2.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //second

                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UserEditProfile(
                                  userUID: userData["user_uid"],
                                  username: userData["user_name"],
                                  useremail: userData["user_email"],
                                  usercontactno: userData["user_contactno"],
                                  userimageurl: userData["user_imageurl"],
                                ),));
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text("EDIT PROFILE",
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
            );
            //ui

          } else{
            return const Center(
              child: Text("NO DATA FOUND!"),
            );
          }

        },
      ),

    );
  }

  Future<Map<dynamic, dynamic>> fetchUserData() async{
    try{
      DatabaseReference databaseReference=FirebaseDatabase.instance.ref("USERS")
        .child(FirebaseAuth.instance.currentUser!.uid);
      await databaseReference.once().then((value) {
        map=value.snapshot.value as Map<dynamic, dynamic>;
      });
    } catch(e){
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
    }
    return map;
  }

}
import 'package:codeverse_user/loginpage.dart';
import 'package:codeverse_user/selectnewprofileimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UserEditProfile extends StatefulWidget {
  String userUID="",username="",useremail="",usercontactno="",userimageurl="";
  UserEditProfile({super.key,required this.userUID,required this.username,required this.useremail,required this.usercontactno,required this.userimageurl});

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {

  bool epasswordVisible=false;
  bool ecpasswordVisible=false;
  final _eformKey=GlobalKey<FormState>();
  final _euserName=TextEditingController();
  final _econtactno=TextEditingController();
  late String user_imageurl;
  Map<dynamic, dynamic> map={};

  @override
  void initState() {
    super.initState();
    epasswordVisible=true;
    ecpasswordVisible=true;
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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _eformKey,
            child: Column(
              children: [

                Lottie.asset(
                  "animation/editprofile_animation.json",
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                  child: TextFormField(
                    controller: _euserName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Username:",
                    ),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Username is Required!";
                      }
                      if(!RegExp(r'^[a-z A-Z]{3,20}$').hasMatch(value))
                      {
                        return "Username is not Valid!";
                      }
                      return null;
                    },
                    onTap: () => _euserName.text=widget.username,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  child: TextFormField(
                    controller: _econtactno,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Contact No.:",
                    ),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Contact Number is Required!";
                      }
                      if(!RegExp(r'^\d{10}$').hasMatch(value))
                      {
                        return "Contact Number is not Valid!";
                      }
                      return null;
                    },
                    onTap: () => _econtactno.text=widget.usercontactno,
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if(_eformKey.currentState!.validate())
                          {
                            updateUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text("NEXT",
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

  Future<void> updateUser() async{

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
        content: const Text("Do you want to chance profile image?",
          style: TextStyle(
            fontFamily: "ComicSansMS3",
            wordSpacing: 2.0,
            letterSpacing: 2.0,
          ),
        ),
        actions: [

          ElevatedButton(
            onPressed: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
              try{
                DatabaseReference databaseReference=FirebaseDatabase.instance.ref("USERS")
                    .child(FirebaseAuth.instance.currentUser!.uid);
                if(widget.username!=_euserName.text) {
                  await databaseReference.update({
                  "user_name":_euserName.text,
                  });
                }
                if(widget.usercontactno!=_econtactno.text) {
                  await databaseReference.update({
                  "user_contactno":_econtactno.text,
                  });
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("PROFILE UPDATED SUCCESSFULLY!",
                      style: TextStyle(
                        fontFamily: "ComicSansMS3",
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                );
              } catch(e) {
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
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
            },
            child: const Text("NO",
              style: TextStyle(
                fontFamily: "ComicSansMS3",
                fontWeight: FontWeight.bold,
                wordSpacing: 2.0,
                letterSpacing: 2.0,
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              userCurrentProfileImageDelete();
              Navigator.pop(context);
            },
            child: const Text("YES",
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

  }

  Future<void> userCurrentProfileImageDelete() async{
    try{
      FirebaseStorage firebasestorage=FirebaseStorage.instance;
      Reference reference=firebasestorage.refFromURL(widget.userimageurl);
      await reference.delete().then((value) async {

        DatabaseReference databaseReference=FirebaseDatabase.instance.ref("USERS")
            .child(FirebaseAuth.instance.currentUser!.uid);
        await databaseReference.update({
          "user_imageurl":"",
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("PROFILE IMAGE DELETED SUCCESSFULLY!",
                style: TextStyle(
                  fontFamily: "ComicSansMS3",
                  fontWeight: FontWeight.bold,
                  wordSpacing: 2.0,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => SelectNewProfileImage(user_name: _euserName.text,user_contactno: _econtactno.text,),));
        });
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
  }

}
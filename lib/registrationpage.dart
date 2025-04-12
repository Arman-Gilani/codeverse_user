import 'package:codeverse_user/loginpage.dart';
import 'package:codeverse_user/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegistrationPage extends StatefulWidget {
  String imageUrl="";
  RegistrationPage({Key? key,required this.imageUrl}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  bool rpasswordVisible=false;
  bool rcpasswordVisible=false;
  final _rformKey=GlobalKey<FormState>();
  final _userName=TextEditingController();
  final _email=TextEditingController();
  final _contactno=TextEditingController();
  final _password=TextEditingController();
  final _cpassword=TextEditingController();

  @override
  void initState() {
    super.initState();
    rpasswordVisible=true;
    rcpasswordVisible=true;
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
            key: _rformKey,
            child: Column(
              children: [

                Lottie.asset(
                  "animation/registration_animation.json",
                  height: 250.0,
                  width: 250.0,
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                  child: TextFormField(
                    controller: _userName,
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
                  ),
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
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

                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  child: TextFormField(
                    controller: _contactno,
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
                  ),
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  child: TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Password:",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            rpasswordVisible=!rpasswordVisible;
                          });
                        },
                        icon: Icon(
                            rpasswordVisible ? Icons.visibility : Icons.visibility_off
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: rpasswordVisible,
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Password is Required!";
                      }
                      if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~!@#$%^&*()|:;,<.>?/]).{10,50}$').hasMatch(value))
                      {
                        return "Password is not Valid!";
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  child: TextFormField(
                    controller: _cpassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Confirm Password:",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            rcpasswordVisible=!rcpasswordVisible;
                          });
                        },
                        icon: Icon(
                            rcpasswordVisible ? Icons.visibility : Icons.visibility_off
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: rcpasswordVisible,
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Confirm Password is Required!";
                      }
                      if(_cpassword.text!=_password.text)
                      {
                        return "Both Passwords doesn't Match!";
                      }
                      return null;
                    },
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if(_rformKey.currentState!.validate())
                          {
                            signUpUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text("SIGNUP",
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 50.0),
                      child: const Text("Already have an account?",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(5.0, 0, 10.0, 50.0),
                        child: const Text("Sign in",
                          style: TextStyle(
                            fontFamily: "ComicSansMS3",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                      },
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

  Future<void> signUpUser() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try{
      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.toString(),
          password: _password.text.toString(),
      );
      User? user=userCredential.user;
      if(user!=null){
        await FirebaseDatabase.instance.ref()
            .child("USERS")
            .child(user.uid)
            .set(
            {
              "user_uid":user.uid,
              "user_name":_userName.text,
              "user_email":_email.text,
              "user_contactno":_contactno.text,
              "user_imageurl":widget.imageUrl,
            }
        ).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("SIGNUP SUCCESSFULLY!",
                style: TextStyle(
                  fontFamily: "ComicSansMS3",
                  fontWeight: FontWeight.bold,
                  wordSpacing: 2.0,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          );
        });
      }
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
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

}
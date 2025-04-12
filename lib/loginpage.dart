import 'package:codeverse_user/forgotpasswordpage.dart';
import 'package:codeverse_user/main.dart';
import 'package:codeverse_user/selectprofileimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isChecked=false;
  bool lpasswordVisible=false;
  final _lformKey=GlobalKey<FormState>();
  final _email=TextEditingController();
  final _password=TextEditingController();

  late Box box;

  @override
  void initState() {
    super.initState();
    lpasswordVisible=true;
    createBox();
  }

  void createBox() async {
    box=await Hive.openBox("loginData");
    getData();
  }
  void getData() async {
    if(box.get("email")!=null) {
      _email.text=box.get("email");
      _isChecked=true;
      setState(() {});
    }
    if(box.get("password")!=null) {
      _password.text=box.get("password");
      _isChecked=true;
      setState(() {});
    }
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
            key: _lformKey,
            child: Column(
              children: [

                Lottie.asset(
                  "animation/login_animation.json",
                  height: 300.0,
                  width: 300.0,
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
                    controller: _password,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Password:",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              lpasswordVisible=!lpasswordVisible;
                            });
                          },
                          icon: Icon(
                              lpasswordVisible ? Icons.visibility : Icons.visibility_off
                          ),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: lpasswordVisible,
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

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      child: Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            _isChecked=!_isChecked;
                            setState(() {});
                          },
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "Remember Me",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 25.0, 0),
                          child: const Text(
                            "Forgot Password?",
                            textAlign: TextAlign.end,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword(),));
                        },
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
                      child: ElevatedButton(
                        onPressed: () {
                          loginButtonPressed();
                          if(_lformKey.currentState!.validate())
                          {
                            signInUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text("LOGIN",
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
                      padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 50.0),
                      child: const Text("Don't have an account?",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(5.0, 0, 20.0, 50.0),
                        child: const Text("Sign up",
                          style: TextStyle(
                            fontFamily: "ComicSansMS3",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectProfileImage(),));
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

  Future<void> signInUser() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.toString(),
          password: _password.text.toString(),
      ).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("LOGIN SUCCESSFULLY!",
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

  void loginButtonPressed() {
    if(_isChecked)
    {
      box.put("email", _email.text.toString());
      box.put("password", _password.text.toString());
    }
  }

}
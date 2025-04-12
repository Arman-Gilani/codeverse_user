import 'package:codeverse_user/settings.dart';
import 'package:codeverse_user/userprofilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String imageURL="";

  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.ref("USERS")
        .child(FirebaseAuth.instance.currentUser!.uid).once().then((value) {
        setState(() {
          Map<dynamic, dynamic> map=value.snapshot.value as Map<dynamic, dynamic>;
          imageURL=map["user_imageurl"];
        });
    });
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
        actions: [

          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 22.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageURL),
              ),
            ),
          ),

        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [

              Text("HOME PAGE!",
                style: TextStyle(
                  fontFamily: "ComicSansMS3",
                  fontWeight: FontWeight.bold,
                  wordSpacing: 2.0,
                  letterSpacing: 2.0,
                ),
              ),

            ],
          ),
        ),
      ),

      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [

              DrawerHeader(
                  child: SafeArea(
                    child: Expanded(
                      child: Image.asset("images/Untitled.png"),
                    ),
                  ),
              ),

              Column(
                children: [

                  InkWell(
                    child: const ListTile(
                      title: Text("Home",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(CupertinoIcons.home),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("Account",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(CupertinoIcons.profile_circled),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfilePage(),));
                    },
                  ),

                  const Divider(
                    height: 2,
                    thickness: 2,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                        child: const Text("Configure",
                          style: TextStyle(
                            fontFamily: "ComicSansMS3",
                            wordSpacing: 2.0,
                            letterSpacing: 2.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("Settings",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(CupertinoIcons.settings),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings(),));
                    },
                  ),

                  const Divider(
                    height: 2,
                    thickness: 2,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                        child: const Text("Communicate",
                          style: TextStyle(
                            fontFamily: "ComicSansMS3",
                            wordSpacing: 2.0,
                            letterSpacing: 2.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("Share",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(Icons.share),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("Feedback",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(Icons.mail_sharp),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("Report a bug",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(Icons.bug_report),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("Suggestions",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(CupertinoIcons.arrow_right_square_fill),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("Rate App",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(CupertinoIcons.star_circle_fill),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  const Divider(
                    height: 2,
                    thickness: 2,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                        child: const Text("Social",
                          style: TextStyle(
                            fontFamily: "ComicSansMS3",
                            wordSpacing: 2.0,
                            letterSpacing: 2.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("About Us",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(Icons.supervisor_account),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  const Divider(
                    height: 2,
                    thickness: 2,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                        child: const Text("Policies",
                          style: TextStyle(
                            fontFamily: "ComicSansMS3",
                            wordSpacing: 2.0,
                            letterSpacing: 2.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("Terms & Condition",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(Icons.content_paste),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("Privacy Policy",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(Icons.privacy_tip_sharp),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("FAQ",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(Icons.contact_support_sharp),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  const Divider(
                    height: 2,
                    thickness: 2,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                        child: const Text("Logout",
                          style: TextStyle(
                            fontFamily: "ComicSansMS3",
                            wordSpacing: 2.0,
                            letterSpacing: 2.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),

                  InkWell(
                    child: const ListTile(
                      title: Text("Logout",
                        style: TextStyle(
                          fontFamily: "ComicSansMS3",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      leading: Icon(Icons.logout),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      FirebaseAuth.instance.signOut().then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("LOGOUT SUCCESSFULLY!",
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
                    },
                  ),

                  const Divider(
                    height: 2,
                    thickness: 2,
                  ),

                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
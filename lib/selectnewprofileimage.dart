import 'dart:io';
import 'package:codeverse_user/finaluserupdatedata.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class SelectNewProfileImage extends StatefulWidget {
  String user_name="",user_contactno="";
  SelectNewProfileImage({super.key,required this.user_name,required this.user_contactno});

  @override
  State<SelectNewProfileImage> createState() => _SelectNewProfileImageState();
}

class _SelectNewProfileImageState extends State<SelectNewProfileImage> {

  String newUserImageURL="";

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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [

                Lottie.asset(
                  "animation/userprofile_animation.json",
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          newUserProfileImage();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text("SELECT PROFILE IMAGE",
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

  Future<void> newUserProfileImage() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    ImagePicker imagePicker=ImagePicker();
    XFile? xFile=await imagePicker.pickImage(source: ImageSource.gallery);
    if(xFile==null) return;
    String uniqueFileName=DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot=FirebaseStorage.instance.ref();
    Reference referenceImageToUpload= referenceRoot.child(uniqueFileName); //referenceDirImages.child(uniqueFileName);
    try {

      await referenceImageToUpload.putFile(File(xFile.path));
      newUserImageURL=await referenceImageToUpload.getDownloadURL();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("NEW PROFILE IMAGE UPLOADED SUCCESSFULLY!",
            style: TextStyle(
              fontFamily: "ComicSansMS3",
              fontWeight: FontWeight.bold,
              wordSpacing: 2.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => FinalUserUpdateData(user_name: widget.user_name, user_contactno: widget.user_contactno, user_imageurl: newUserImageURL),));
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
  }

}
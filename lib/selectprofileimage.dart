import 'dart:io';
import 'package:codeverse_user/registrationpage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class SelectProfileImage extends StatefulWidget {
  const SelectProfileImage({Key? key}) : super(key: key);

  @override
  State<SelectProfileImage> createState() => _SelectProfileImageState();
}

class _SelectProfileImageState extends State<SelectProfileImage> {

  PlatformFile? platformFile;
  UploadTask? uploadTask;
  String imageUrl="";

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
                          userProfileImage();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage(imageUrl:imageUrl),));
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

  Future<void> userProfileImage() async {

    ImagePicker imagePicker=ImagePicker();
    XFile? xFile=await imagePicker.pickImage(source: ImageSource.gallery);
    if(xFile==null) return;
    String uniqueFileName=DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot=FirebaseStorage.instance.ref();
    Reference referenceImageToUpload= referenceRoot.child(uniqueFileName); //referenceDirImages.child(uniqueFileName);
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      await referenceImageToUpload.putFile(File(xFile.path));
      imageUrl=await referenceImageToUpload.getDownloadURL();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("PROFILE IMAGE UPLOADED SUCCESSFULLY!",
            style: TextStyle(
              fontFamily: "ComicSansMS3",
              fontWeight: FontWeight.bold,
              wordSpacing: 2.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage(imageUrl:imageUrl),));
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
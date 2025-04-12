import 'package:codeverse_user/loginpage.dart';
import 'package:codeverse_user/registrationpage.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin=true;
  @override
  Widget build(BuildContext context) =>
      isLogin ? const LoginPage() : RegistrationPage(imageUrl: "",);
}
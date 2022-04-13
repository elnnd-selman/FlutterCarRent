import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:print_color/print_color.dart';

class HelperScreen extends StatefulWidget {
  HelperScreen({Key? key}) : super(key: key);

  @override
  State<HelperScreen> createState() => _HelperScreenState();
}

class _HelperScreenState extends State<HelperScreen> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/onboarding');
      });
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Icon(
          Icons.car_rental,
          size: 100,
          color: Colors.blue,
        ),
      ),
    );
  }
}

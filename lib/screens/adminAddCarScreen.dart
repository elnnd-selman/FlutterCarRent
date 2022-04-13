import 'package:flutter/material.dart';

import '../services/firestore.dart';
import '../widgets/customButton.dart';
import '../widgets/textInputCustom.dart';

class AdminAddCarScreen extends StatefulWidget {
  AdminAddCarScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddCarScreen> createState() => _AdminAddCarScreenState();
}

class _AdminAddCarScreenState extends State<AdminAddCarScreen> {
 bool loadButton = false;
  String errorText = '';
  bool errorChck = false;
  Map<String, dynamic> _carInfo = {};
  GlobalKey<FormState> _globalKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child:Text('data')
        ),
      )),
    );
  }
}
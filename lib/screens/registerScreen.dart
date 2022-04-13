import 'package:carrent/services/auth.dart';
import 'package:carrent/widgets/customButton.dart';
import 'package:carrent/widgets/textInputCustom.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePass = false;
  bool loadButton = false;
  String errorText = '';
  bool errorChck = false;
  Map<String, dynamic> _userInfo = {};
  GlobalKey<FormState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset('assets/images/carsRegister.png'),
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.left,
                        text_hint: 'Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter name';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _userInfo['name'] = value;
                          });
                        },
                        hintTextStyle:
                            TextStyle(color: Color.fromARGB(255, 91, 91, 91)),
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.left,
                        text_hint: 'Email',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter email';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _userInfo['email'] = value;
                          });
                        },
                        hintTextStyle:
                            TextStyle(color: Color.fromARGB(255, 61, 61, 61)),
                      ),
                      CustomTextField(
                        icon2: Container(
                            width: 60, child: Center(child: Text('+964'))),
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.left,
                        text_hint: 'Phone number',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter Phone number';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _userInfo['phoneNumber'] = value;
                          });
                        },
                        hintTextStyle:
                            TextStyle(color: Color.fromARGB(255, 61, 61, 61)),
                      ),
                      CustomTextField(
                        obscureText: _obscurePass,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.left,
                        text_hint: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter email';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _userInfo['password'] = value;
                          });
                        },
                        hintTextStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 103, 103)),
                      ),
                      if (errorChck)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            errorText,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      loadButton
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              fontColor: Colors.white,
                              splashColor: Colors.green,
                              text: 'register',
                              ontab: () async {
                                if (_globalKey.currentState!.validate()) {
                                  _globalKey.currentState!.save();
                                  setState(() {
                                    loadButton = true;
                                  });
                                  var response = await AuthService().register(
                                    phoneNumber:  _userInfo['phoneNumber'],
                                      email: _userInfo['email'],
                                      password: _userInfo['password'],
                                      name: _userInfo['name']);
                                  if (response != null &&
                                      response != 'userAdded') {
                                    var text = response.toString().split(']');
                                    setState(() {
                                      errorText = text[1];
                                      errorChck = true;
                                      loadButton = false;
                                    });
                                  } else {
                                    setState(() {
                                      errorChck = false;
                                      loadButton = false;
                                    });
                                    Navigator.pushNamed(context, '/home');
                                  }
                                }
                              },
                              color: Colors.blue)
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}

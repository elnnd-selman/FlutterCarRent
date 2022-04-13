import 'package:carrent/services/auth.dart';
import 'package:carrent/widgets/customButton.dart';
import 'package:carrent/widgets/textInputCustom.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePass = false;
  bool loadButton = false;
  String errorText = '';
  bool errorChck = false;
  Map<String, dynamic> _userInfo = {};
  GlobalKey<FormState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                  'https://ouch-cdn2.icons8.com/jUVsvGx8nL0aKho6aX4TezGZa23zFoFBa9-TszvXULs/rs:fit:256:256/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNzkw/Lzg2NDVlNDllLTcx/ZDItNDM1NC04YjM5/LWI0MjZkZWI4M2Zk/MS5zdmc.png'),
              Form(
                  key: _globalKey,
                  child: Column(
                    children: [
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
                              text: 'Login',
                              ontab: () async {
                                if (_globalKey.currentState!.validate()) {
                                  _globalKey.currentState!.save();
                                  setState(() {
                                    loadButton = true;
                                  });
                                  var response = await AuthService().login(
                                      email: _userInfo['email'],
                                      password: _userInfo['password']);
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

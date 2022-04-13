import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/firestore.dart';
import '../widgets/customButton.dart';
import '../widgets/textInputCustom.dart';

class AdminCreateCarsScreen extends StatefulWidget {
  const AdminCreateCarsScreen({Key? key}) : super(key: key);

  @override
  State<AdminCreateCarsScreen> createState() => _AdminCreateCarsScreenState();
}

class _AdminCreateCarsScreenState extends State<AdminCreateCarsScreen> {
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
                        text_hint: 'Name of car',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter name';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _carInfo['name'] = value;
                          });
                        },
                        hintTextStyle:
                            TextStyle(color: Color.fromARGB(255, 91, 91, 91)),
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.left,
                        text_hint: 'Brand name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter brand name';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _carInfo['brand'] = value;
                          });
                        },
                        hintTextStyle:
                            TextStyle(color: Color.fromARGB(255, 61, 61, 61)),
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.left,
                        text_hint: 'Model',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter model';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _carInfo['model'] = value;
                          });
                        },
                        hintTextStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 103, 103)),
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        textAlign: TextAlign.left,
                        text_hint: 'Speed',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter speed';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _carInfo['speed'] = value;
                          });
                        },
                        hintTextStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 103, 103)),
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.left,
                        text_hint: 'Image Url',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please Image Url in official car account - page - website';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _carInfo['imageUrl'] = value;
                          });
                        },
                        hintTextStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 103, 103)),
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.left,
                        text_hint: 'About',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter about car';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _carInfo['about'] = value;
                          });
                        },
                        hintTextStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 103, 103)),
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        textAlign: TextAlign.left,
                        text_hint: 'door',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter door number';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _carInfo['door'] = value;
                          });
                        },
                        hintTextStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 103, 103)),
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.left,
                        text_hint: 'is 4*4',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter yes if 4*4 ';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _carInfo['is_4By4'] = value;
                          });
                        },
                        hintTextStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 103, 103)),
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        textAlign: TextAlign.left,
                        text_hint: 'enter money per hour',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter money per hour';
                          }
                        },
                        onSave: (value) {
                          setState(() {
                            _carInfo['moneyPerHour'] = value;
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
                              text: 'add',
                              ontab: () async {
                                if (_globalKey.currentState!.validate()) {
                                  _globalKey.currentState!.save();
                                  setState(() {
                                    loadButton = true;
                                  });
                                  
                                  var response = await FireStoreServices()
                                      .createCar(
                                          about: _carInfo['about'],
                                          brand: _carInfo['brand'],
                                          door: _carInfo['door'],
                                          isRegister: 'false',
                                          is_4By4: _carInfo['is_4By4'],
                                          model: _carInfo['model'],
                                          moneyPerHour: double.parse(
                                              _carInfo['moneyPerHour']),
                                          speed: _carInfo['speed'],
                                          name: _carInfo['name'],
                                          imageUrl: _carInfo['imageUrl']);

                                  if (response != null && response != 'added') {
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

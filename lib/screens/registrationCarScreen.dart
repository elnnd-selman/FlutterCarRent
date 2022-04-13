// ignore: file_names
import 'package:carrent/model/registrationCar.dart';
import 'package:carrent/services/firestore.dart';
import 'package:carrent/widgets/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:print_color/print_color.dart';
import '../model/carModel.dart';

class RegsitrationCarScreen extends StatefulWidget {
  const RegsitrationCarScreen({Key? key}) : super(key: key);

  @override
  State<RegsitrationCarScreen> createState() => _RegsitrationCarScreenState();
}

class _RegsitrationCarScreenState extends State<RegsitrationCarScreen> {
  bool errorCheckDate = false;
  bool errorCheck = false;
  String errorText = '';
  String _fromDate = '';
  String _toDate = '';
  bool _didiChangeOnes = true;
  String carId = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didiChangeOnes) {
      carId = ModalRoute.of(context)!.settings.arguments as String;
      _didiChangeOnes = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    popNav() {
      Navigator.pop(context);
    }

    var stream =
        FirebaseFirestore.instance.collection('cars').doc(carId).snapshots();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          child: StreamBuilder<DocumentSnapshot>(
            stream: stream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              CardModel car = CardModel.fromJson(
                  snapshot.data!.data()! as Map<String, dynamic>);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/fadeImage.gif',
                                image: car.imageUrl,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(color: Colors.blue),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      buildRow(
                                          text: 'Name',
                                          iconData: Icons.directions_car),
                                      buildRow(
                                          iconData: Icons.branding_watermark,
                                          text: car.brand),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      buildRow(
                                          iconData: Icons.history,
                                          text: car.model),
                                      buildRow(
                                          iconData: Icons.speed,
                                          text: car.speed + ' km' + '/h'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      buildRow(
                                          iconData: Icons.money,
                                          text: car.moneyPerHour.toString() +
                                              '/h'),
                                      buildRow(
                                          text: car.door,
                                          iconData: Icons.door_front_door)
                                    ],
                                  ),
                                  ExpandableText(
                                    'About: ' + car.about,
                                    expanded: false,
                                    expandText: 'show more',
                                    maxLines: 2,
                                    linkColor: Colors.blue,
                                    animation: true,
                                    collapseOnTextTap: true,
                                    linkStyle: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                    hashtagStyle: const TextStyle(
                                      color: Color(0xFF30B6F9),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    DateTime? result = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(
                                        const Duration(days: 30),
                                      ),
                                    );
                                    if (result == null) {
                                      return;
                                    }
                                    var date =
                                        DateFormat('yyy-MM-dd').format(result);
                                    setState(() {
                                      _fromDate = date;
                                    });
                                  },
                                  child: const Text(
                                    'From',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                              if (_fromDate != '')
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    _fromDate,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                            ],
                          ),
                          _fromDate != ''
                              ? Row(
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        await showDatePicker(
                                          context: context,
                                          initialDate:
                                              DateTime.parse(_fromDate),
                                          firstDate: DateTime.parse(_fromDate),
                                          lastDate:
                                              DateTime.parse(_fromDate).add(
                                            const Duration(days: 30),
                                          ),
                                        ).then((value) {
                                          if (value == null) {
                                            return;
                                          }
                                          var date = DateFormat('yyy-MM-dd')
                                              .format(value);
                                          setState(() {
                                            _toDate = date;
                                          });
                                        });
                                      },
                                      child: const Text('To'),
                                    ),
                                    _toDate != ''
                                        ? Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              _toDate,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : SizedBox()
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                      if (_fromDate != '' && _toDate != '')
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.money,
                                color: Colors.blue,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                (daysBetween(_fromDate, _toDate) *
                                            car.moneyPerHour)
                                        .toString() +
                                    ' \$',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                  // if (errorCheck)
                  //   Padding(
                  //     padding: EdgeInsets.all(10),
                  //     child: Text(
                  //       errorText,
                  //       style: TextStyle(color: Colors.red),
                  //     ),
                  //   ),

                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('registrationCar')
                        .where('carId', isEqualTo: carId)
                        .get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasData) {
                        List<RegistrationCarModel> registrationCars = snapshot
                            .data!.docs
                            .map((e) => RegistrationCarModel.fromJson(e.data()))
                            .toList();
                        bool userHaveCar = registrationCars.any((element) =>
                            element.userId ==
                            FirebaseAuth.instance.currentUser!.uid);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              registrationCars.length < 1
                                  ? SizedBox()
                                  : const Text(
                                      'Not available in those Date time',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                              registrationCars.length < 1
                                  ? SizedBox()
                                  : Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.blue)),
                                      child: ListView.builder(
                                        itemCount: registrationCars.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.blue),
                                            child: Text(
                                              'From ' +
                                                  registrationCars[index].from +
                                                  ' To ' +
                                                  registrationCars[index].to,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              if (errorCheckDate)
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'car unavailable in this date time , pleas check (Not available list)',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 248, 0, 0)),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CustomButton(
                                    fontColor: Colors.white,
                                    splashColor: Colors.grey,
                                    text: userHaveCar
                                        ? 'You have car in registration method'
                                        : 'Register the car',
                                    ontab: () {
                                      setState(() {
                                        errorCheckDate = false;
                                      });
                                      if (userHaveCar) {
                                        return;
                                      }
                                      for (var element in registrationCars) {
                                        //to la pesh towakan
                                        //from la dway from
                                        Print.yellow(element);
                                        if ((toDateFun(_toDate).isBefore(
                                                toDateFun(element.to)) &&
                                            toDateFun(_toDate).isAfter(
                                                toDateFun(element.from)))) {
                                          setState(() {
                                            errorCheckDate = true;
                                          });
                                          return;
                                        }

                                        if ((toDateFun(_fromDate).isBefore(
                                                toDateFun(element.to)) &&
                                            toDateFun(_fromDate).isAfter(
                                                toDateFun(element.from)))) {
                                          setState(() {
                                            errorCheckDate = true;
                                          });
                                          return;
                                        }
                                        if ((toDateFun(_toDate).isAfter(
                                                toDateFun(element.to)) &&
                                            toDateFun(_fromDate).isBefore(
                                                toDateFun(element.from)))) {
                                          setState(() {
                                            errorCheckDate = true;
                                          });
                                          return;
                                        }
                                        if ((toDateFun(_toDate).isAfter(
                                                toDateFun(element.to)) &&
                                            toDateFun(_fromDate).isBefore(
                                                toDateFun(element.to)))) {
                                          setState(() {
                                            errorCheckDate = true;
                                          });
                                          return;
                                        }
                                        // if ((toDateFun(_toDate).isBefore(
                                        //         toDateFun(element.to)) &&
                                        //     toDateFun(_fromDate).isAfter(
                                        //         toDateFun(element.from)))) {}
                                        // //to la dway to
                                        // //from la pesh
                                        // if ((toDateFun(_toDate).isAfter(
                                        //         toDateFun(element.to)) &&
                                        //     toDateFun(_fromDate).isBefore(
                                        //         toDateFun(element.to)))) {}

                                        // if ((toDateFun(_toDate).isAfter(
                                        //         toDateFun(element.to)) &&
                                        //     toDateFun(_fromDate).isBefore(
                                        //         toDateFun(element.to)))) {}

                                        // if ((toDateFun(_toDate).isAfter(
                                        //         toDateFun(element.to)) ||
                                        //     toDateFun(_fromDate).isBefore(
                                        //         toDateFun(element.to)))) {}
                                      }

                                      if (_fromDate == '' || _toDate == '') {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please enter the (from) date and to (date)",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0); // setState(() {

                                        return;
                                      }
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text('Are you sure?'),
                                                content: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Name: ' + car.name),
                                                    Text('Date time: ' +
                                                        _fromDate +
                                                        ' to ' +
                                                        _toDate),
                                                    Text('you pay: ' +
                                                        (daysBetween(_fromDate,
                                                                    _toDate) *
                                                                car.moneyPerHour)
                                                            .toString() +
                                                        ' \$')
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                    child: Text('yes'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                    child: Text('cancel'),
                                                  ),
                                                ],
                                              )).then((value) async {
                                        if (value) {
                                          await FireStoreServices().registerCar(
                                              userId: FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              pay: (daysBetween(
                                                          _fromDate, _toDate) *
                                                      car.moneyPerHour)
                                                  .toString(),
                                              carId: carId,
                                              from: _fromDate,
                                              to: _toDate);

                                          popNav();
                                        }
                                      });
                                    },
                                    color: _fromDate == '' || _toDate == ''
                                        ? Colors.grey
                                        : Colors.blue),
                              )
                            ],
                          ),
                        );
                      }

                      return Text('Loading.....');
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  int daysBetween(String from, String to) {
    // ignore: non_constant_identifier_names
    var From = DateTime.parse(from);
    // ignore: non_constant_identifier_names
    var To = DateTime.parse(to);
    return (To.difference(From).inHours / 24).round();
  }

  DateTime toDateFun(date) {
    return DateTime.parse(date);
  }
}

Widget buildRow({required String text, required IconData iconData}) {
  return Expanded(
    child: Row(
      children: [
        Icon(
          iconData,
          color: Colors.white,
          size: 30,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        )
      ],
    ),
  );
}

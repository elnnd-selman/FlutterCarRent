import 'package:carrent/model/userModel.dart';
import 'package:carrent/services/firestore.dart';
import 'package:carrent/services/mail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:print_color/print_color.dart';

import '../model/carModel.dart';
import '../model/registrationCar.dart';
import '../widgets/carCartWidget.dart';

class AdminAcceptCarScreen extends StatefulWidget {
  AdminAcceptCarScreen({Key? key}) : super(key: key);

  @override
  State<AdminAcceptCarScreen> createState() => _AdminAcceptCarScreenState();
}

class _AdminAcceptCarScreenState extends State<AdminAcceptCarScreen> {
  int bottonSelect = 1;
  String status = 'false';
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      bottonSelect = 1;
                      status = 'true';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: bottonSelect == 1 ? Colors.blue : Colors.white,
                        border: Border.all(color: Colors.blue, width: 2)),
                    child: Text(
                      'Accepted',
                      style: TextStyle(
                          color:
                              bottonSelect == 1 ? Colors.white : Colors.blue),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      bottonSelect = 2;
                      status = 'false';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: bottonSelect == 2 ? Colors.blue : Colors.white,
                        border: Border.all(color: Colors.blue, width: 2)),
                    child: Text(
                      'Requested',
                      style: TextStyle(
                          color:
                              bottonSelect == 2 ? Colors.white : Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('registrationCar')
                  .where('accept', isEqualTo: status)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  height: 600,
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      RegistrationCarModel data = RegistrationCarModel.fromJson(
                          document.data()! as Map<String, dynamic>);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Text(
                                email,
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                data.pay + ' \$',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                ' -From- ' + data.from + ' -To- ' + data.to,
                                style: TextStyle(color: Colors.blue),
                              ),
                              FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('cars')
                                    .doc(data.carId)
                                    .get(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snapshott) {
                                  if (snapshott.hasError) {
                                    return const Text(
                                      "Something went wrong",
                                      style: TextStyle(color: Colors.white),
                                    );
                                  }

                                  if (snapshott.connectionState ==
                                      ConnectionState.done) {
                                    CardModel carData = CardModel.fromJson(
                                        snapshott.data!.data()
                                            as Map<String, dynamic>);

                                    return Column(
                                      children: [
                                        Text(
                                          'Name: ' + carData.name,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Text(
                                          'Brand: ' + carData.brand,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Text(
                                          'Model: ' + carData.model,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Text('have not any data');
                                },
                              ),
                              Row(
                                children: [
                                  bottonSelect == 2
                                      ? TextButton(
                                          onPressed: () async {
                                            await FireStoreServices().acceptCar(
                                                registerCarId: data.id,
                                                status: 'true');
                                          },
                                          child: Text(
                                            'Accept',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                      : SizedBox(),
                                  bottonSelect == 1
                                      ? TextButton(
                                          onPressed: () async {
                                            await FireStoreServices().acceptCar(
                                                registerCarId: data.id,
                                                status: 'false');
                                          },
                                          child: Text(
                                            'Remove to Request',
                                            style: TextStyle(color: Colors.red),
                                          ))
                                      : TextButton(
                                          onPressed: () async {
                                            await FireStoreServices()
                                                .deleteRequestRegisterCar(
                                              registerCarId: data.id,
                                            );
                                          },
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          )),
                                ],
                              ),
                              bottonSelect == 1
                                  ? FutureBuilder(
                                      future: FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(data.userId)
                                          .get(),
                                      builder: (context,
                                          AsyncSnapshot<DocumentSnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          return Text("Something went wrong");
                                        }

                                        if (snapshot.hasData &&
                                            !snapshot.data!.exists) {
                                          return Text(
                                              "Document does not exist");
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          UserModel userModel =
                                              UserModel.fromJson(
                                                  snapshot.data!.data()
                                                      as Map<String, dynamic>);
                                          return Column(
                                            children: [
                                              Text('email ' + userModel.email),
                                              TextButton(
                                                  onPressed: () async {
                                                    var response =
                                                        await SendMailServices
                                                            .sendMail(
                                                                userModel.email,
                                                                'Car Restore',
                                                                "'Please return this car you took. It's over.'");
                                                    if (response == 'sended') {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "messege will sended",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  4,
                                                                  233,
                                                                  38),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize:
                                                              16.0); // setState(() {

                                                    }
                                                  },
                                                  child: Text(
                                                    'Send Email to get back the car',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                            ],
                                          );
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
          // FutureBuilder<QuerySnapshot>(
          //   future: FirebaseFirestore.instance
          //       .collection('registrationCar')
          //       .where('accept', isEqualTo: 'false')
          //       .get(),
          //   builder: (BuildContext context,
          //       AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          //     if (snapshot.hasError) {
          //       return const Text(
          //         "Something went wrong",
          //         style: TextStyle(color: Colors.white),
          //       );
          //     }

          //     if (snapshot.connectionState == ConnectionState.done) {
          //       List<RegistrationCarModel> data = snapshot.data!.docs
          //           .map((e) => RegistrationCarModel.fromJson(
          //               e.data() as Map<String, dynamic>))
          //           .toList();
          //       return Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Container(
          //           padding: const EdgeInsets.all(20),
          //           decoration: BoxDecoration(
          //               color: Colors.blue,
          //               borderRadius: BorderRadius.circular(30)),
          //           height: 600,
          //           child: ListView.builder(
          //             itemCount: data.length,
          //             physics: const NeverScrollableScrollPhysics(),
          //             itemBuilder: (context, index) {
          //               return Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Container(
          //                   padding: const EdgeInsets.all(8.0),
          //                   decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       borderRadius: BorderRadius.circular(10)),
          //                   child: Column(
          //                     children: [
          //                       Text(
          //                         data[index].pay + ' \$',
          //                         style: TextStyle(color: Colors.blue),
          //                       ),
          //                       Text(
          //                         ' -From- ' +
          //                             data[index].from +
          //                             ' -To- ' +
          //                             data[index].to,
          //                         style: TextStyle(color: Colors.blue),
          //                       ),
          //                       FutureBuilder(
          //                         future: FirebaseFirestore.instance
          //                             .collection('cars')
          //                             .doc(data[index].carId)
          //                             .get(),
          //                         builder: (context,
          //                             AsyncSnapshot<DocumentSnapshot>
          //                                 snapshott) {
          //                           if (snapshott.hasError) {
          //                             return const Text(
          //                               "Something went wrong",
          //                               style: TextStyle(color: Colors.white),
          //                             );
          //                           }

          //                           if (snapshott.connectionState ==
          //                               ConnectionState.done) {
          //                             CardModel carData = CardModel.fromJson(
          //                                 snapshott.data!.data()
          //                                     as Map<String, dynamic>);

          //                             return Column(
          //                               children: [
          //                                 Text(
          //                                   'Name: ' + carData.name,
          //                                   style: const TextStyle(
          //                                     color: Colors.blue,
          //                                   ),
          //                                 ),
          //                                 Text(
          //                                   'Brand: ' + carData.brand,
          //                                   style: const TextStyle(
          //                                     color: Colors.blue,
          //                                   ),
          //                                 ),
          //                                 Text(
          //                                   'Model: ' + carData.model,
          //                                   style: const TextStyle(
          //                                     color: Colors.blue,
          //                                   ),
          //                                 ),
          //                               ],
          //                             );
          //                           }
          //                           return Text('have not any data');
          //                         },
          //                       ),
          //                       Row(
          //                         children: [
          //                           TextButton(
          //                               onPressed: () {},
          //                               child: Text(
          //                                 'Accept',
          //                                 style: TextStyle(color: Colors.green),
          //                               )),
          //                           TextButton(
          //                               onPressed: () {},
          //                               child: Text(
          //                                 'Remove',
          //                                 style: TextStyle(color: Colors.red),
          //                               ))
          //                         ],
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       );
          //     }

          //     return const Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}

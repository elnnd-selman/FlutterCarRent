import 'dart:ui';

import 'package:carrent/model/carModel.dart';
import 'package:carrent/model/registrationCar.dart';
import 'package:carrent/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class myAccountScreen extends StatelessWidget {
  const myAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
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

              UserModel user = UserModel.fromJson(
                  snapshot.data!.data()! as Map<String, dynamic>);

              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Text(
                          user.name,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          user.email,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          user.phoneNumber,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('registrationCar')
                            .where('userId',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                          if (snapshot.hasError) {
                            return const Text(
                              "Something went wrong",
                              style: TextStyle(color: Colors.white),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            List<RegistrationCarModel> data = snapshot
                                .data!.docs
                                .map((e) => RegistrationCarModel.fromJson(
                                    e.data() as Map<String, dynamic>))
                                .toList();
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                height: 500,
                                child: ListView.builder(
                                  itemCount: data.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            Text(
                                              data[index].accept == 'true'
                                                  ? 'Accepted'
                                                  : 'Your request in procces',
                                              style: TextStyle(
                                                  color: data[index].accept ==
                                                          'true'
                                                      ? Color.fromARGB(
                                                          255, 68, 243, 33)
                                                      : Color.fromARGB(
                                                          255, 237, 2, 2)),
                                            ),
                                            Text(
                                              data[index].pay + ' \$',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            Text(
                                              ' -From- ' +
                                                  data[index].from +
                                                  ' -To- ' +
                                                  data[index].to,
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            FutureBuilder(
                                              future: FirebaseFirestore.instance
                                                  .collection('cars')
                                                  .doc(data[index].carId)
                                                  .get(),
                                              builder: (context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot>
                                                      snapshott) {
                                                if (snapshott.hasError) {
                                                  return const Text(
                                                    "Something went wrong",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  );
                                                }

                                                if (snapshott.connectionState ==
                                                    ConnectionState.done) {
                                                  CardModel carData =
                                                      CardModel.fromJson(
                                                          snapshott.data!.data()
                                                              as Map<String,
                                                                  dynamic>);

                                                  return Column(
                                                    children: [
                                                      Text(
                                                        carData.name,
                                                        style: const TextStyle(
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                                return Text(
                                                    'have not any data');
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                    ],
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

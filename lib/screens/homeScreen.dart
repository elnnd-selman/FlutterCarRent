import 'dart:ui';

import 'package:carrent/model/carModel.dart';
import 'package:carrent/model/userModel.dart';
import 'package:carrent/services/auth.dart';
import 'package:carrent/services/firestore.dart';
import 'package:carrent/widgets/carCartWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:print_color/print_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;
  // ignore: non_constant_identifier_names
  bool is_admin = false;
  String carIsRegister = '';
  Stream<QuerySnapshot<Map<String, dynamic>>> stream =
      FirebaseFirestore.instance.collection('cars').snapshots();
  isAdmin() async {
    UserModel userCheck = await AuthService().isAdmin(_user!.uid);
    if (userCheck.admin == 1) {
      setState(() {
        is_admin = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isAdmin();
  }

  @override
  Widget build(BuildContext context) {
    List<Map> logoBrand = [
      {
        "logo":
            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Republic_Of_Korea_Broadcasting-TV_Rating_System%28ALL%29.svg/1200px-Republic_Of_Korea_Broadcasting-TV_Rating_System%28ALL%29.svg.png',
        'text': 'all'
      },
      {
        "logo":
            'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/1200px-Mercedes-Logo.svg.png',
        'text': 'mercedes'
      },
      {
        "logo": 'https://justcars.info/blog/bmw-logo-1997-1200x1200.png',
        'text': 'bmw'
      },
      {
        "logo":
            'https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Nissan-logo.svg/892px-Nissan-logo.svg.png',
        'text': 'nissan'
      },
      {
        "logo":
            'https://www.pngall.com/wp-content/uploads/2016/04/Toyota-Logo-Free-Download-PNG.png',
        'text': 'toyota'
      },
    ];

    // Print.yellow(FirebaseAuth.instance.currentUser!.email);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/my-account');
            }),
        actions: [
          TextButton(
              onPressed: () async {
                await AuthService().logout();
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                'LogOut',
                style: TextStyle(color: Colors.white),
              )),
          if (is_admin)
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin-create-car');
                },
                child: Text(
                  'add car',
                  style: TextStyle(color: Colors.white),
                )),
          if (is_admin)
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin-accept-car');
                },
                child: Text(
                  'requests car',
                  style: TextStyle(color: Colors.white),
                )),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 90,
              width: double.infinity,
              child: ListView.builder(
                itemCount: logoBrand.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (logoBrand[index]['text'] == 'all') {
                            stream = FirebaseFirestore.instance
                                .collection('cars')
                                .snapshots();
                          } else {
                            stream = FirebaseFirestore.instance
                                .collection('cars')
                                .where('brand',
                                    isEqualTo: logoBrand[index]['text'])
                                .snapshots();
                          }
                        });
                      },
                      child: Container(
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: Image.network(logoBrand[index]['logo'])),
                    ),
                  );
                },
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Expanded(
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      CardModel car = CardModel.fromJson(
                          document.data()! as Map<String, dynamic>);

                      return CarCartWidget(car: car);
                    }).toList(),
                  ),
                );
              })
        ],
      )),
    );
  }
}

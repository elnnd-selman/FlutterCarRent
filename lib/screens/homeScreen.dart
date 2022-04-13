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
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        carIsRegister == 'false'
            ? FirebaseFirestore.instance
                .collection('cars')
                .where('isRegister', isEqualTo: 'false')
                .snapshots()
            : carIsRegister == 'true'
                ? FirebaseFirestore.instance
                    .collection('cars')
                    .where('isRegister', isEqualTo: 'true')
                    .snapshots()
                : FirebaseFirestore.instance.collection('cars').snapshots();
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
          StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
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

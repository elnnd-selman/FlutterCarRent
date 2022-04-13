import 'dart:convert';

import 'package:carrent/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:print_color/print_color.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future register(
      {required String email,
      required String phoneNumber,
      required String password,
      required String name}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var userId = credential.user!.uid;
      await firestore.collection('users').doc(userId).set({
        'id': userId,
        'name': name,
        'email': email,
        'admin': 0,
        'phoneNumber': '+964' + phoneNumber
      });
      return 'userAdded';
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'logined';
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel> isAdmin(userId) async {
    var userData = await firestore.collection('users').doc(userId).get();

    UserModel user =
        UserModel.fromJson(userData.data() as Map<String, dynamic>);
    print(user.admin);
    return user;
  }

  Stream<User?> get user =>
      FirebaseAuth.instance.authStateChanges().map((user) => user);
}

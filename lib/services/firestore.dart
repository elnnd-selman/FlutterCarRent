import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:print_color/print_color.dart';
import 'package:uuid/uuid.dart';

class FireStoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future createCar(
      {required String name,
      required String imageUrl,
      required String model,
      required String brand,
      required String isRegister,
      required String speed,
      required String about,
      required String door,
      required String is_4By4,
      required double moneyPerHour}) async {
    try {
      var carID = Uuid().v1();
      await _firestore.collection('cars').doc(carID).set({
        'id': carID,
        'imageUrl': imageUrl,
        'name': name,
        'model': model,
        'brand': brand,
        'isRegister': isRegister,
        'speed': speed,
        'about': about,
        'door': door,
        'is_4By4': is_4By4,
        'moneyPerHour': moneyPerHour
      });
      return 'added';
    } catch (e) {
      Print.red(e);
      return e;
    }
  }

  Future getCars() async {
    return await _firestore.collection('cars').get();
  }

  Future registerCar(
      {required String userId,
      required String pay,
      required String carId,
      required String from,
      required String to}) async {
    var id = const Uuid().v1();
    _firestore.collection('registrationCar').doc(id).set({
      'accept': 'false',
      'id': id,
      'userId': userId,
      'pay': pay,
      'carId': carId,
      'from': from,
      'to': to,
    });
  }

  Future deleteRequestRegisterCar({
    required String registerCarId,
  }) async {
    await _firestore.collection('registrationCar').doc(registerCarId).delete();
  }

  Future acceptCar(
      {required String registerCarId, required String status}) async {
    try {
      Print.yellow(registerCarId);
      await _firestore
          .collection('registrationCar')
          .doc(registerCarId)
          .update({'accept': status});
    } catch (e) {
      print(e);
    }
  }
}

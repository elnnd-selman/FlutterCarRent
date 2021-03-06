import 'package:carrent/screens/adminAcceptCarScreen.dart';
import 'package:carrent/screens/adminCreateCarsScreen.dart';
import 'package:carrent/screens/helperScreen.dart';
import 'package:carrent/screens/homeScreen.dart';
import 'package:carrent/screens/login.dart';
import 'package:carrent/screens/myAccount.dart';
import 'package:carrent/screens/onboardingScreen.dart';
import 'package:carrent/screens/registerScreen.dart';
import 'package:carrent/screens/registrationCarScreen.dart';
import 'package:carrent/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
          create: (context) => AuthService().user,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HelperScreen(),
        routes: {
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/registration-car': (context) => RegsitrationCarScreen(),
          // '/admin-creaddte-car': (context) => AdminAddCarScreen(),
          '/admin-create-car': (context) => AdminCreateCarsScreen(),
          '/my-account': (context) => myAccountScreen(),
          '/admin-accept-car': (context) => AdminAcceptCarScreen(),
          '/onboarding': (context) => OnboardingSceen(),
          '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}

import 'package:carrent/screens/statusScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_screen/OnbordingData.dart';
import 'package:flutter_onboarding_screen/flutteronboardingscreens.dart';

class OnboardingSceen extends StatelessWidget {
  /*here we have a list of OnbordingScreen which we want to have, each OnbordingScreen have a imagePath,title and an desc.
      */
  final List<OnbordingData> list = [
    OnbordingData(
      imagePath: "assets/images/car1.png",
      title: "Enjoy",
      desc: "premuim app car rental, Enjoy the CarRental",
    ),
    OnbordingData(
      imagePath: "assets/images/car2.png",
      title: "Needed",
      desc:
          "Best CarRental App delivering to your doorstep, Browse List Car and build your own Request in seconds",
    ),
    OnbordingData(
      imagePath: "assets/images/car3.png",
      title: "Easy",
      desc: "Easy to register the car.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    /* remove the back button in the AppBar is to set automaticallyImplyLeading to false
  here we need to pass the list and the route for the next page to be opened after this. */
    return IntroScreen(
      list,
      MaterialPageRoute(builder: (context) => StatusScreen()),
    );
  }
}

import 'package:carrent/model/carModel.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class CarCartWidget extends StatelessWidget {
  final CardModel car;
  CarCartWidget({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(30)),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/fadeImage.gif',
                        image: car.imageUrl,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(color: Colors.blue),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildRow(
                                  text: 'Name', iconData: Icons.directions_car),
                              buildRow(
                                  iconData: Icons.branding_watermark,
                                  text: car.brand),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildRow(
                                  iconData: Icons.history, text: car.model),
                              buildRow(
                                  iconData: Icons.speed,
                                  text: car.speed + ' km' + '/h'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildRow(
                                  iconData: Icons.money,
                                  text: car.moneyPerHour.toString() + '/day'),
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
                                color: Colors.red, fontWeight: FontWeight.bold),
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
                Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/registration-car',
                            arguments: car.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(198, 33, 149, 243)),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
              ],
            )),
      ),
    );
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

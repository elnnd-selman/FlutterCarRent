import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback ontab;
  final bool? enable;
  final Color? color;
  final Color? splashColor;
  final Color? fontColor;
  const CustomButton({
    Key? key,
    required this.fontColor,
    required this.splashColor,
    required this.text,
    required this.ontab,
    this.enable,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                blurRadius: .1,
                color: Colors.grey,
                offset: Offset(-1, 1),
                spreadRadius: 0),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            borderOnForeground: true,
            color: color,
            child: InkWell(
              splashColor: splashColor,
              onTap: ontab,
              onTapDown: (value) {},
              child: SizedBox(
                height: 50,
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: fontColor,
                  ),
                )),
              ),
            ),
          ),
        ));
  }
}

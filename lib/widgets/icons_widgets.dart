import 'package:flutter/material.dart';
import 'package:new_motel/widgets/fade_animation.dart';

class IconsWidget extends StatelessWidget {
  late String title;
  late Widget child;
  late double delayanimation;
  late Color color;
  IconsWidget({
    Key? key,
    required this.title,
    required this.child,
    required this.delayanimation,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeAnimation(
                delay: delayanimation,
                child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color, // OxFF17334E
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: child)),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        FadeAnimation(
            delay: delayanimation,
            child: Text(title, style: const TextStyle(color: Colors.black)))
      ],
    );
  }
}

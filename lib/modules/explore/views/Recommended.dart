import 'package:flutter/material.dart';
import 'package:new_motel/widgets/bottom_top_move_animation_view.dart';

class Recommeded extends StatelessWidget {
  final AnimationController animationController;
  const Recommeded({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomTopMoveAnimationView(
      animationController: animationController,
      child: Center(
        child: Text("reccomeded"),
      ),
    );
  }
}

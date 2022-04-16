import 'package:flutter/material.dart';
import 'package:new_motel/widgets/bottom_top_move_animation_view.dart';

class Popular extends StatelessWidget {
  final AnimationController listener;

  const Popular({Key? key, required this.listener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomTopMoveAnimationView(
      animationController: listener,
      child: const Center(child: Text("Popular")),
    );
  }
}

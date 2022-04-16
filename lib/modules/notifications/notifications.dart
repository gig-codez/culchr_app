import 'package:flutter/material.dart';
import 'package:new_motel/widgets/bottom_top_move_animation_view.dart';

class Notifications extends StatefulWidget {
  final AnimationController animationController;
  const Notifications({Key? key, required this.animationController})
      : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return BottomTopMoveAnimationView(
        animationController: widget.animationController, child: Container());
  }
}

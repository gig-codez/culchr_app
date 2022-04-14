import 'package:flutter/material.dart';
import 'package:new_motel/models/hotel_list_data.dart';
import 'package:new_motel/widgets/common_card.dart';

class HomeEventWidget extends StatefulWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;
  HomeEventWidget(
      {Key? key,
      required this.isShowDate,
      required this.callback,
      required this.hotelData,
      required this.animationController,
      required this.animation})
      : super(key: key);

  @override
  State<HomeEventWidget> createState() => _HomeEventWidgetState();
}

class _HomeEventWidgetState extends State<HomeEventWidget> {
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.hotelData.imagePath),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Theme.of(context).backgroundColor.withOpacity(1),
              Theme.of(context).backgroundColor.withOpacity(0.5),
            ],
          )),
          child: Text(
            widget.hotelData.titleTxt,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

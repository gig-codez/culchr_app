import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_motel/constants/helper.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/appLocalizations.dart';
import 'package:new_motel/logic/providers/theme_provider.dart';
import 'package:new_motel/models/enum.dart';
import 'package:new_motel/models/hotel_list_data.dart';
import 'package:new_motel/widgets/common_card.dart';
import 'package:new_motel/widgets/list_cell_animation_view.dart';
import 'package:provider/provider.dart';

class HotelListViewPage extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;

  const HotelListViewPage({
    Key? key,
    required this.hotelData,
    required this.animationController,
    required this.animation,
    required this.callback,
    this.isShowDate: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: CommonCard(
          color: AppTheme.backgroundColor,
          child: ClipRRect(
            //   borderRadius: BorderRadius.all(Radius.circular(0.0)),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(hotelData.imagePath),
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
                  ),
                ),
                child: Text(
                  hotelData.titleTxt,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

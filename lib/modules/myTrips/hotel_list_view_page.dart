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
        padding: const EdgeInsets.all(10),
        child: CommonCard(
          color: AppTheme.backgroundColor,
          child: ClipRRect(
            //   borderRadius: BorderRadius.all(Radius.circular(0.0)),
            child: Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(hotelData.imagePath),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(0.0),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    hotelData.titleTxt,
                    textScaleFactor: 2,
                    style: TextStyles(context).getRegularStyle().copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

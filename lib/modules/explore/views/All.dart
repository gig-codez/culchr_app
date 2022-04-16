import 'package:flutter/material.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/appLocalizations.dart';
import 'package:new_motel/models/hotel_list_data.dart';
import 'package:new_motel/routes/route_names.dart';

import '../popular_list_view.dart';
import '../title_view.dart';

class All extends StatelessWidget {
  final AnimationController animationController;
  final ScrollController scrollController;
  const All(
      {Key? key,
      required this.animationController,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getDealListView() {
      var hotelList = HotelListData.hotelList;
      return PopularListView(
        animationController: animationController,
        callBack: (index) {
          NavigationServices(context).gotoHotelDetailes(hotelList[index]);
        },
        listData: hotelList,
      );
    }

    var sliderImageHieght = MediaQuery.of(context).size.width * 0.5;
    return Container(
      color: AppTheme.scaffoldBackgroundColor,
      child: ListView.builder(
        controller: scrollController,
        itemCount: 6,
        // padding on top is only for we need spec for sider
        padding: EdgeInsets.only(top: sliderImageHieght + 32, bottom: 16),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          // some list UI
          var count = 8;
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / count) * index, 1.0,
                  curve: Curves.fastOutSlowIn),
            ),
          );
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TitleView(
                titleTxt: AppLocalizations(context).of("trend"),
                subTxt: AppLocalizations(context).of("view_all"),
                animation: animation,
                isLeftButton: true,
                animationController: animationController,
                click: () {},
              ),
            );
          } else if (index == 1) {
            return getDealListView();
          } else if (index == 2) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TitleView(
                titleTxt: AppLocalizations(context).of("best_deal"),
                subTxt: AppLocalizations(context).of("view_all"),
                animation: animation,
                isLeftButton: true,
                animationController: animationController,
                click: () {},
              ),
            );
          } else if (index == 3) {
            return getDealListView();
          } else if (index == 4) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TitleView(
                titleTxt: AppLocalizations(context).of("popular"),
                subTxt: AppLocalizations(context).of("view_all"),
                animation: animation,
                isLeftButton: true,
                animationController: animationController,
                click: () {},
              ),
            );
          } else {
            return getDealListView();
          }
        },
      ),
    );
  }
}

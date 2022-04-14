import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/appLocalizations.dart';
import 'package:new_motel/logic/providers/theme_provider.dart';
import 'package:new_motel/models/enum.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:new_motel/widgets/bottom_top_move_animation_view.dart';
import 'package:new_motel/widgets/common_button.dart';
import 'package:new_motel/widgets/common_card.dart';
import 'package:new_motel/widgets/common_search_bar.dart';
import '../../models/hotel_list_data.dart';
import 'home_explore_slider_view.dart';
import 'popular_list_view.dart';
import 'title_view.dart';
import 'package:provider/provider.dart';

class HomeExploreScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeExploreScreen({Key? key, required this.animationController})
      : super(key: key);
  @override
  _HomeExploreScreenState createState() => _HomeExploreScreenState();
}

class _HomeExploreScreenState extends State<HomeExploreScreen>
    with TickerProviderStateMixin {
  var hotelList = HotelListData.hotelList;
  late ScrollController controller;
  late AnimationController _animationController;
  var sliderImageHieght = 0.0;
  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);
    controller
      ..addListener(() {
        if (mounted) {
          if (controller.offset < 0) {
            // we static set the just below half scrolling values
            _animationController.animateTo(0.0);
          } else if (controller.offset > 0.0 &&
              controller.offset < sliderImageHieght) {
            // we need around half scrolling values
            if (controller.offset < ((sliderImageHieght / 1.5))) {
              _animationController
                  .animateTo((controller.offset / sliderImageHieght));
            } else {
              // we static set the just above half scrolling values "around == 0.64"
              _animationController
                  .animateTo((sliderImageHieght / 1.5) / sliderImageHieght);
            }
          }
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sliderImageHieght = MediaQuery.of(context).size.width * 0.3;
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) => Stack(
          children: <Widget>[
            Container(
              color: AppTheme.scaffoldBackgroundColor,
              child: ListView.builder(
                controller: controller,
                itemCount: 8,
                // padding on top is only for we need spec for sider
                padding:
                    EdgeInsets.only(top: sliderImageHieght + 32, bottom: 16),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  // some list UI
                  var count = 8;
                  var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  if (index == 0) {
                    return TitleView(
                      titleTxt: AppLocalizations(context).of("best_deal"),
                      subTxt: AppLocalizations(context).of("view_all"),
                      animation: animation,
                      isLeftButton: true,
                      animationController: widget.animationController,
                      click: () {},
                    );
                  } else if (index == 1) {
                    return getDealListView();
                  } else if (index == 2) {
                    return TitleView(
                      titleTxt: AppLocalizations(context).of("best_deal"),
                      subTxt: AppLocalizations(context).of("view_all"),
                      animation: animation,
                      isLeftButton: true,
                      animationController: widget.animationController,
                      click: () {},
                    );
                  } else if (index == 3) {
                    return getDealListView();
                  } else if (index == 4) {
                    return TitleView(
                      titleTxt: AppLocalizations(context).of("best_deal"),
                      subTxt: AppLocalizations(context).of("view_all"),
                      animation: animation,
                      isLeftButton: true,
                      animationController: widget.animationController,
                      click: () {},
                    );
                  } else if (index == 5) {
                    return getDealListView();
                  } else if (index == 6) {
                    return TitleView(
                      titleTxt: AppLocalizations(context).of("best_deal"),
                      subTxt: AppLocalizations(context).of("view_all"),
                      animation: animation,
                      isLeftButton: true,
                      animationController: widget.animationController,
                      click: () {},
                    );
                  } else {
                    return getDealListView();
                  }
                },
              ),
            ),
            // sliderUI with 3 images are moving
            // _sliderUI(),

            // viewHotels Button UI for click event
            // _viewHotelsButton(_animationController),

            //just gradient for see the time and battry Icon on "TopBar"
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Theme.of(context).backgroundColor.withOpacity(0.4),
                    Theme.of(context).backgroundColor.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
              ),
            ),
            //   serachUI on Top  Positioned
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              child: serachUI(),
            )
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _viewHotelsButton(AnimationController _animationController) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        var opecity = 1.0 -
            (_animationController.value > 0.64
                ? 1.0
                : _animationController.value);
        return Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: sliderImageHieght * (1.0 - _animationController.value),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 32,
                left: context.read<ThemeProvider>().languageType ==
                        LanguageType.ar
                    ? null
                    : 24,
                right: context.read<ThemeProvider>().languageType ==
                        LanguageType.ar
                    ? 24
                    : null,
                child: Opacity(
                  opacity: opecity,
                  child: CommonButton(
                    onTap: () {
                      if (opecity != 0) {
                        NavigationServices(context).gotoHotelHomeScreen();
                      }
                    },
                    buttonTextWidget: Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Text(
                        AppLocalizations(context).of("view_hotel"),
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(color: AppTheme.whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sliderUI() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          // we calculate the opecity between 0.64 to 1.0
          var opecity = 1.0 -
              (_animationController.value > 0.64
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: sliderImageHieght * (1.0 - _animationController.value),
            child: HomeExploreSliderView(
              opValue: opecity,
              click: () {},
            ),
          );
        },
      ),
    );
  }

  Widget getDealListView() {
    var hotelList = HotelListData.hotelList;
    // List<Widget> list = List.generate(hotelList.length, (index) {
    //   var animation = Tween(begin: 0.0, end: 1.0).animate(
    //     CurvedAnimation(
    //       parent: widget.animationController,
    //       curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn),
    //     ),
    //   );
    //   return HotelListViewPage(
    //     callback: () {
    //       NavigationServices(context).gotoHotelDetailes(hotelList[index]);
    //     },
    //     hotelData: hotelList[index],
    //     animation: animation,
    //     animationController: widget.animationController,
    //   );
    // });
    return PopularListView(
      animationController: widget.animationController,
      callBack: (index) {},
      listData: hotelList,
    );
  }

  Widget serachUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: CommonCard(
        radius: 36,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(38)),
          onTap: () {
            NavigationServices(context).gotoSearchScreen();
          },
          child: CommonSearchBar(
            iconData: FontAwesomeIcons.search,
            enabled: false,
            text: AppLocalizations(context).of("where_are_you_going"),
          ),
        ),
      ),
    );
  }
}

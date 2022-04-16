// ignore_for_file: constant_identifier_names

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/appLocalizations.dart';
import 'package:new_motel/logic/providers/theme_provider.dart';
import 'package:new_motel/modules/explore/views/Recommended.dart';
import 'package:new_motel/widgets/bottom_top_move_animation_view.dart';
import 'package:new_motel/widgets/common_card.dart';
import 'package:new_motel/widgets/tap_effect.dart';
import '../../models/hotel_list_data.dart';
import 'package:provider/provider.dart';

import 'views/All.dart';
import 'views/Popular.dart';

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
  late Widget currentPage;
  late AnimationController _animationController, tabAnimationController;
  var sliderImageHieght = 0.0;
  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    tabAnimationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);
    controller.addListener(() {
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

  TopBarType topBarType = TopBarType.All;
  @override
  Widget build(BuildContext context) {
    currentPage = All(
      animationController: widget.animationController,
      scrollController: controller,
    );

    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) => Stack(
          children: <Widget>[
            currentPage,
            //just gradient for see the time and battry Icon on "TopBar"
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).backgroundColor.withOpacity(0.4),
                      Theme.of(context).backgroundColor.withOpacity(0.0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            //   serachUI on Top  Positioned
            AnimatedBuilder(
              builder: (BuildContext context, Widget? child) {
                var opecity = 1.0 -
                    (_animationController.value > 0.64
                        ? 1.0
                        : _animationController.value);
                sliderImageHieght = MediaQuery.of(context).size.width * 0.065;
                return Positioned(
                  top: sliderImageHieght * (1.0 - _animationController.value),
                  // top: (1.0 - _animationController.value),
                  left: 0,
                  right: 0,
                  child: Material(
                    color:
                        Theme.of(context).backgroundColor.withOpacity(opecity),
                    child: Opacity(
                      opacity: opecity,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top),
                            child: Container(child: _getappBar()),
                          ),
                          tabViewUI(topBarType),
                        ],
                      ),
                    ),
                  ),
                );
              },
              animation: _animationController,
            )
          ],
        ),
      ),
    );
  }

// tab and appbar UI
  void tabClick(TopBarType tabType) {
    if (tabType != topBarType) {
      topBarType = tabType;
      tabAnimationController.reverse().then((f) {
        if (tabType == TopBarType.All) {
          setState(() {
            currentPage = All(
              animationController: widget.animationController,
              scrollController: controller,
            );
          });
        } else if (tabType == TopBarType.Popular) {
          setState(() {
            currentPage = Popular(
              listener: tabAnimationController,
            );
          });
        } else if (tabType == TopBarType.Recommeded) {
          setState(() {
            currentPage =
                Recommeded(animationController: tabAnimationController);
          });
        }
      });
    }
  }

  Widget tabViewUI(TopBarType tabType) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CommonCard(
        color: AppTheme.backgroundColor,
        radius: 36,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _getTopBarUi(() {
                    tabClick(TopBarType.All);
                  },
                      tabType == TopBarType.All
                          ? AppTheme.primaryColor
                          : AppTheme.secondaryTextColor,
                      "all"),
                  _getTopBarUi(() {
                    tabClick(TopBarType.Popular);
                  },
                      tabType == TopBarType.Popular
                          ? AppTheme.primaryColor
                          : AppTheme.secondaryTextColor,
                      "popular"),
                  _getTopBarUi(() {
                    tabClick(TopBarType.Recommeded);
                  },
                      tabType == TopBarType.Recommeded
                          ? AppTheme.primaryColor
                          : AppTheme.secondaryTextColor,
                      "recommend"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTopBarUi(VoidCallback onTap, Color color, String text) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(32.0)),
          highlightColor: Colors.transparent,
          splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            child: Center(
              child: Text(
                AppLocalizations(context).of(text),
                style: TextStyles(context)
                    .getRegularStyle()
                    .copyWith(fontWeight: FontWeight.w600, color: color),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getappBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 0.0, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: AnimatedTextKit(
              repeatForever: true,
              totalRepeatCount: 1000,
              animatedTexts: [
                TypewriterAnimatedText(
                  AppLocalizations(context).of("culchr"),
                  textStyle:
                      TextStyles(context).getBoldStyle().copyWith(fontSize: 22),
                ),
                TypewriterAnimatedText(
                  AppLocalizations(context).of("dis"),
                  textStyle:
                      TextStyles(context).getBoldStyle().copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TapEffect(
                  onClick: () {},
                  child: Badge(
                      position: const BadgePosition(
                        top: -1,
                        end: -1,
                      ),
                      child:
                          const CircleAvatar(child: Icon(Icons.notifications))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TapEffect(
                  onClick: () {},
                  child: Badge(
                    padding: EdgeInsets.zero,
                    badgeContent: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Live",
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    shape: BadgeShape.square,
                    position: const BadgePosition(
                      bottom: -1,
                    ),
                    child: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

enum TopBarType { All, Recommeded, Popular }

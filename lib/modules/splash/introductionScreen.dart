import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_motel/constants/localfiles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/appLocalizations.dart';
import 'package:new_motel/modules/splash/components/page_pop_view.dart';
import 'package:new_motel/widgets/common_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/login_screen.dart';
import '../login/sign_up_Screen.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen>
    with SingleTickerProviderStateMixin {
  var pageController = PageController(initialPage: 0);
  late AnimationController bottomAnimationController;
  List<PageViewData> pageViewModelData = [];

  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    bottomAnimationController = AnimationController(
      // value: 50,
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    pageViewModelData.add(PageViewData(
      titleText: 'Exclusive access to every event',
      subText:
          'Be the first to know of your favourite event and get exclusive access to it.',
      assetsImage: Localfiles.introduction,
    ));

    pageViewModelData.add(PageViewData(
      titleText: 'Discover experieces around you.',
      subText:
          'Discover and travel to all the exihilarating experiences around you. ',
      assetsImage: Localfiles.introduction1,
    ));

    pageViewModelData.add(PageViewData(
      titleText: 'The party doesn’t stop with Nightlife',
      subText:
          'Stay in the loop with insights of every nightlife activity near and around you',
      assetsImage: Localfiles.introduction2,
    ));

    pageViewModelData.add(PageViewData(
      titleText: 'Seamless Entry With CulchrPass',
      subText: 'Using our reusable wristband, get access to every event ',
      assetsImage: Localfiles.introduction3,
    ));

    sliderTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width,
            duration: const Duration(seconds: 5), curve: Curves.decelerate);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(MediaQuery.of(context).size.width * 2,
            duration: const Duration(seconds: 5), curve: Curves.decelerate);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(MediaQuery.of(context).size.width * 3,
            duration: const Duration(seconds: 5), curve: Curves.decelerate);
      } else if (currentShowIndex == 3) {
        pageController.animateTo(0,
            duration: const Duration(seconds: 5), curve: Curves.decelerate);
      }
    });
    super.initState();
  }

  double height = 250;

  @override
  void dispose() {
    sliderTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          pageSnapping: true,
          onPageChanged: (index) {
            setState(() {
              currentShowIndex = index;
            });
          },
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            PagePopup(imageData: pageViewModelData[0]),
            PagePopup(imageData: pageViewModelData[1]),
            PagePopup(imageData: pageViewModelData[2]),
            PagePopup(imageData: pageViewModelData[3]),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        child: Center(
          child: Column(
            children: [
              SmoothPageIndicator(
                controller: pageController, // PageController
                count: pageViewModelData.length, // total page count
                effect: WormEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                    dotColor: Colors.white38,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    spacing: 5.0), // your preferred effect
                onDotClicked: (index) {
                  setState(() {
                    currentShowIndex = index;
                  });
                },
              ),
              CommonButton(
                padding: const EdgeInsets.only(
                    left: 48, right: 48, bottom: 8, top: 32),
                buttonText: AppLocalizations(context).of("login"),
                onTap: () => showLoginUi(),
              ),
              CommonButton(
                padding: const EdgeInsets.only(
                    left: 48, right: 48, bottom: 32, top: 8),
                buttonText: AppLocalizations(context).of("create_account"),
                backgroundColor: AppTheme.backgroundColor,
                textColor: AppTheme.primaryTextColor,
                onTap: () => showSignUi(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLoginUi() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.2,
            child: const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: ClipRRect(
                child: LoginScreen(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          );
        });
  }

  showSignUi() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.2,
            child: const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: ClipRRect(
                child: SignUpScreen(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          );
        });
  }
}

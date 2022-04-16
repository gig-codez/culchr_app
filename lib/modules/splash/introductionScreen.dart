import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_motel/constants/localfiles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/appLocalizations.dart';
import 'package:new_motel/modules/splash/components/page_pop_view.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:new_motel/widgets/common_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];

  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
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

    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width,
            duration: const Duration(seconds: 3), curve: Curves.decelerate);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(MediaQuery.of(context).size.width * 2,
            duration: const Duration(seconds: 3), curve: Curves.decelerate);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(MediaQuery.of(context).size.width * 3,
            duration: const Duration(seconds: 3), curve: Curves.decelerate);
      } else if (currentShowIndex == 3) {
        pageController.animateTo(0,
            duration: const Duration(seconds: 3), curve: Curves.decelerate);
      }
    });
    super.initState();
  }

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
            currentShowIndex = index;
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
                onDotClicked: (index) {},
              ),
              CommonButton(
                padding: const EdgeInsets.only(
                    left: 48, right: 48, bottom: 8, top: 32),
                buttonText: AppLocalizations(context).of("login"),
                onTap: () {
                  NavigationServices(context).gotoLoginScreen();
                },
              ),
              CommonButton(
                padding: const EdgeInsets.only(
                    left: 48, right: 48, bottom: 32, top: 8),
                buttonText: AppLocalizations(context).of("create_account"),
                backgroundColor: AppTheme.backgroundColor,
                textColor: AppTheme.primaryTextColor,
                onTap: () {
                  NavigationServices(context).gotoSignScreen();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

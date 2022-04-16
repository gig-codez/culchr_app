import 'package:flutter/material.dart';
import 'package:new_motel/constants/localfiles.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/appLocalizations.dart';
import 'package:new_motel/logic/providers/theme_provider.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:new_motel/widgets/common_button.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoadText = false;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        _loadAppLocalizations()); // call after first frame receiver so we have context
    super.initState();
  }

  Future<void> _loadAppLocalizations() async {
    try {
      //load all text json file to allLanguageTextData(in common file)
      //   await AppLocalizations.init(context);
      setState(() {
        isLoadText = true;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(Localfiles.introduction),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              padding: EdgeInsets.zero,
              foregroundDecoration: !appTheme.isLightMode
                  ? BoxDecoration(
                      color: Theme.of(context).backgroundColor.withOpacity(0.4))
                  : null,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Column(
              children: <Widget>[
                // Center(
                //   child: Container(
                //     width: 60,
                //     height: 60,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(8.0),
                //       ),
                //       boxShadow: <BoxShadow>[
                //         BoxShadow(
                //             color: Theme.of(context).dividerColor,
                //             offset: Offset(1.1, 1.1),
                //             blurRadius: 10.0),
                //       ],
                //     ),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(8.0),
                //       ),
                //       child: Image.asset(Localfiles.appIcon),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.1,
                ),
                Center(
                  child: Text(
                    "Culchr.",
                    textAlign: TextAlign.center,
                    textScaleFactor: 2.1,
                    style: TextStyles(context)
                        .getBoldStyle()
                        .copyWith(fontSize: 20, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                AnimatedOpacity(
                  opacity: isLoadText ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 420),
                  child: Text(
                    AppLocalizations(context).of("best_hotel_deals"),
                    textAlign: TextAlign.left,
                    style: TextStyles(context).getRegularStyle().copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                const Expanded(
                  flex: 4,
                  child: SizedBox(),
                ),
                AnimatedOpacity(
                  opacity: isLoadText ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 680),
                  child: CommonButton(
                    padding: const EdgeInsets.only(
                        left: 48, right: 48, bottom: 8, top: 8),
                    buttonText: AppLocalizations(context).of("get_started"),
                    onTap: () {
                      NavigationServices(context).gotoIntroductionScreen();
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                )
                // AnimatedOpacity(
                //   opacity: isLoadText ? 1.0 : 0.0,
                //   duration: Duration(milliseconds: 1200),
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //         bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                //         top: 16),
                //     child: Text(
                //       AppLocalizations(context).of("already_have_account"),
                //       textAlign: TextAlign.left,
                //       style: TextStyles(context).getDescriptionStyle().copyWith(
                //             color: AppTheme.whiteColor,
                //           ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

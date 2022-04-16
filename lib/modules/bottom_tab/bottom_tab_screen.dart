import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/appLocalizations.dart';
import 'package:new_motel/logic/providers/theme_provider.dart';
import 'package:new_motel/modules/bottom_tab/components/tab_button_UI.dart';
import 'package:new_motel/modules/hotel_detailes/search_screen.dart';
import 'package:provider/provider.dart';
import '../explore/home_explore.dart';
import '../myTrips/my_trips_screen.dart';
import '../profile/profile_screen.dart';

class BottomTabScreen extends StatefulWidget {
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isFirstTime = true;
  Widget _indexView = Container();
  BottomBarType bottomBarType = BottomBarType.Explore;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _indexView = Container();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _startLoadScreen());
    super.initState();
  }

  Future _startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      _isFirstTime = false;
      _indexView = HomeExploreScreen(
        animationController: _animationController,
      );
    });
    _animationController..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, provider, child) => Container(
        child: Scaffold(
          floatingActionButton: Container(child: getBottomBarUI(bottomBarType)),
          body: _isFirstTime
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : _indexView,
        ),
      ),
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      _animationController.reverse().then((f) {
        if (tabType == BottomBarType.Explore) {
          setState(() {
            _indexView = HomeExploreScreen(
              animationController: _animationController,
            );
          });
        } else if (tabType == BottomBarType.SearchSearch) {
          setState(() {
            _indexView = SearchScreen();
          });
        } else if (tabType == BottomBarType.Tickets) {
          setState(() {
            _indexView = MyTripsScreen(
              animationController: _animationController,
            );
          });
        } else if (tabType == BottomBarType.Profile) {
          setState(() {
            _indexView = ProfileScreen(
              animationController: _animationController,
            );
          });
        }
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return Container(
      padding: EdgeInsets.all(3),
      height: MediaQuery.of(context).size.height / 13,
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18)),
          boxShadow: [
            BoxShadow(
                color: AppTheme.backgroundColor.withOpacity(0.1),
                blurRadius: .5,
                spreadRadius: .5,
                offset: const Offset(0, 1))
          ]),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TabButtonUI(
                icon: Icons.explore_rounded,
                isSelected: tabType == BottomBarType.Explore,
                text: AppLocalizations(context).of("discover"),
                onTap: () {
                  tabClick(BottomBarType.Explore);
                },
              ),
              TabButtonUI(
                icon: Icons.search_rounded,
                isSelected: tabType == BottomBarType.SearchSearch,
                text: "Search",
                onTap: () {
                  tabClick(BottomBarType.SearchSearch);
                },
              ),
              TabButtonUI(
                icon: Icons.airplane_ticket_rounded,
                isSelected: tabType == BottomBarType.Tickets,
                text: "Tickets",
                onTap: () {
                  tabClick(BottomBarType.Tickets);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.user,
                isSelected: tabType == BottomBarType.Profile,
                text: AppLocalizations(context).of("profile"),
                onTap: () {
                  tabClick(BottomBarType.Profile);
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}

enum BottomBarType { Explore, Tickets, Profile, SearchSearch }

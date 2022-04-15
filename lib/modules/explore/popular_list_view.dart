import 'package:flutter/material.dart';
import 'package:new_motel/modules/explore/category_view.dart';
import 'package:new_motel/widgets/bottom_top_move_animation_view.dart';
import '../../constants/text_styles.dart';
import '../../models/hotel_list_data.dart';

class PopularListView extends StatefulWidget {
  final Function(int) callBack;
  final AnimationController animationController;
  final List<HotelListData> listData;
  PopularListView(
      {Key? key,
      required this.callBack,
      required this.animationController,
      required this.listData})
      : super(key: key);
  @override
  _PopularListViewState createState() => _PopularListViewState();
}

class _PopularListViewState extends State<PopularListView>
    with TickerProviderStateMixin {
  var popularList = HotelListData.popularList;
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(
      const Duration(milliseconds: 50),
    );
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomTopMoveAnimationView(
      animationController: animationController!,
      child: Container(
        height: 180,
        width: double.infinity,
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 24, left: 8),
                itemCount: widget.listData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var count = popularList.length > 10 ? 5 : popularList.length;
                  var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();
                  //Population animation photo and text view
                  Size size = MediaQuery.of(context).size;
                  return AnimatedBuilder(
                      animation: widget.animationController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: size.width / 2,
                              height: size.height / 2,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      widget.listData[index].imagePath),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Theme.of(context)
                                          .backgroundColor
                                          .withOpacity(0.5),
                                      Theme.of(context)
                                          .backgroundColor
                                          .withOpacity(0.0),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.listData[index].titleTxt,
                                    style: TextStyles(context).getTitleStyle(),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              widget.callBack(index);
                            },
                          ),
                        );
                      });
                },
              );
            }
          },
        ),
      ),
    );
  }
}

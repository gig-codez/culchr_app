import 'package:flutter/material.dart';
import 'package:new_motel/widgets/bottom_top_move_animation_view.dart';
import '../../constants/themes.dart';
import '../../models/hotel_list_data.dart';

class PopularListView extends StatefulWidget {
  final Function(int) callBack;
  final AnimationController animationController;
  final List<HotelListData> listData;
  const PopularListView(
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
        duration: const Duration(milliseconds: 1000), vsync: this);
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
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.primaryColor,
                ),
              );
            } else {
              return ListView.separated(
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
                            child: PhysicalModel(
                              color: Colors.transparent,
                              elevation: 3,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                width: size.width / 2,
                                height: size.height / 2,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      widget.listData[index].imagePath,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: size.width,
                                  height: size.height,
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        Colors.black.withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.1,
                                        ),
                                        Text(
                                          widget.listData[index].titleTxt,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Text(widget.listData[index].subTxt,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14)),
                                      ],
                                    ),
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
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 20,
                    height: 20,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

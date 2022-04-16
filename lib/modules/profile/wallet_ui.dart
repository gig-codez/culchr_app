// ignore: file_names
import 'package:flutter/material.dart';
import 'package:new_motel/widgets/icons_widgets.dart';
import 'package:new_motel/widgets/tap_effect.dart';

class WalletUI extends StatefulWidget {
  const WalletUI({Key? key}) : super(key: key);

  @override
  State<WalletUI> createState() => _WalletUIState();
}

class _WalletUIState extends State<WalletUI> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      height: size.height / 6,
      width: size.width,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              0.0, // Move to right 10  horizontally
              0.0, // Move to bottom 10 Vertically
            ),
          )
        ],
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            //action buttons
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TapEffect(
                    onClick: () {},
                    child: IconsWidget(
                      title: "TopUP",
                      child: const Icon(Icons.add_box_rounded,
                          color: Colors.white, size: 30),
                      delayanimation: 1.5,
                      color: const Color(0xFF17334E),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  TapEffect(
                    onClick: () {},
                    child: IconsWidget(
                        title: "Withdraw",
                        child: const Icon(
                          Icons.file_download_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        delayanimation: 1.7,
                        color: const Color(0xFF163333)),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  TapEffect(
                    onClick: () {},
                    child: IconsWidget(
                        title: "Pay",
                        child: const Icon(Icons.payments,
                            color: Colors.white, size: 30),
                        delayanimation: 1.9,
                        color: const Color(0xFF411C2E)),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  TapEffect(
                    onClick: () {},
                    child: IconsWidget(
                        title: "Transactions",
                        child: const Icon(
                          Icons.receipt_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        delayanimation: 2.1,
                        color: const Color(0xFF32204D)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

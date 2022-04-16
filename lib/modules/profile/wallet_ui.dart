// ignore: file_names
import 'package:flutter/material.dart';
import 'package:new_motel/widgets/icons_widgets.dart';

class WalletUI extends StatefulWidget {
  WalletUI({Key? key}) : super(key: key);

  @override
  State<WalletUI> createState() => _WalletUIState();
}

class _WalletUIState extends State<WalletUI> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
            topRight: Radius.circular(55),
            bottomLeft: Radius.circular(55),
            bottomRight: Radius.circular(55)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 120,
          ),
          //action buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconsWidget(
                    title: "TopUP",
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_box_rounded)),
                    delayanimation: 1.5,
                    color: const Color(0xFF17334E)),
                SizedBox(
                  width: size.width * 0.03,
                ),
                IconsWidget(
                    title: "Withdraw",
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.file_download_outlined)),
                    delayanimation: 1.7,
                    color: const Color(0xFF163333)),
                SizedBox(
                  width: size.width * 0.03,
                ),
                IconsWidget(
                    title: "Pay",
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.payments)),
                    delayanimation: 1.9,
                    color: const Color(0xFF411C2E)),
                SizedBox(
                  width: size.width * 0.03,
                ),
                IconsWidget(
                    title: "Transactions",
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.receipt_rounded)),
                    delayanimation: 2.1,
                    color: const Color(0xFF32204D))
              ],
            ),
          )
        ],
      ),
    );
  }
}

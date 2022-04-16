import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_motel/widgets/common_button.dart';

class FacebookTwitterButtonView extends StatelessWidget {
  const FacebookTwitterButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _fTButtonUI();
  }

  Widget _fTButtonUI() {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: CommonButton(
            padding: EdgeInsets.zero,
            backgroundColor: Color.fromARGB(255, 228, 69, 116),
            buttonTextWidget: _buttonTextUI(),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: CommonButton(
            padding: EdgeInsets.zero,
            backgroundColor: const Color.fromARGB(255, 9, 10, 10),
            buttonTextWidget: _buttonTextUI(isFacebook: false),
          ),
        ),
        const SizedBox(
          width: 24,
        )
      ],
    );
  }

  Widget _buttonTextUI({bool isFacebook: true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(isFacebook ? FontAwesomeIcons.googlePlus : FontAwesomeIcons.apple,
            size: 25, color: Colors.white),
        // const SizedBox(
        //   width: 2,
        // ),
        Text(
          isFacebook ? "Google" : "Apple",
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';

class TabButtonUI extends StatelessWidget {
  IconData? icon;
  final Function()? onTap;
  final bool isSelected;
  String? image;
  final String text;
  final bool useIcon;
  TabButtonUI(
      {Key? key,
      this.onTap,
      this.image,
      this.icon,
      required this.isSelected,
      required this.text,
      required this.useIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color =
        isSelected ? AppTheme.primaryColor : AppTheme.secondaryTextColor;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
          onTap: onTap,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 4,
              ),
              useIcon
                  ? Container(
                      width: 40,
                      height: 32,
                      child: Icon(
                        icon,
                        size: 26,
                        color: _color,
                      ),
                    )
                  : Container(
                      width: 40,
                      height: 32,
                      child: Image.asset(image!),
                    ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    text,
                    style: TextStyles(context).getDescriptionStyle().copyWith(
                          color: _color,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

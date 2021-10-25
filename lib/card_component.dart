import 'package:flutter/material.dart';

import 'custom_colors.dart';

class CardComponent extends StatelessWidget {
  CardComponent({
    Key? key,
    required this.txt,
    required this.type,
    this.left = false,
    this.top = false,
    this.bottom = false,
    this.right = false,
  }) : super(key: key);

  final String txt;
  final String type;
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  var borderSide = BorderSide(
    color: CustomColors.borderColor,
    width: 3.0,
  );

  var borderSideEmpty = BorderSide.none;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(8.0),
      height: (MediaQuery.of(context).size.width - 40) / 3,
      width: (MediaQuery.of(context).size.width - 40) / 3,
      decoration: BoxDecoration(
        border: Border(
          left: left ? borderSide : borderSideEmpty,
          right: right ? borderSide : borderSideEmpty,
          bottom: bottom ? borderSide : borderSideEmpty,
          top: top ? borderSide : borderSideEmpty,
        ),
      ),
      child: Center(
          child: Text(
        txt,
        style: TextStyle(
          color: type == 'X' ? CustomColors.xColor : CustomColors.oColor,
          fontWeight: FontWeight.bold,
          fontSize: 60,
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rickmorty/core/widgets/text.dart';
import 'package:rickmorty/core/themes/text_theme.dart';

class RMButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const RMButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 0.4),
            ]),
        child: Center(
            child: RMText(
          text: text,
          type: RMTextTypes.cardSub,
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rickmorty/core/widgets/text.dart';
import 'package:rickmorty/core/themes/text_theme.dart';

class RMInfoContainer extends StatelessWidget {
  const RMInfoContainer({
    Key? key,
    required this.title,
    required this.text,
    this.date,
  }) : super(key: key);

  final String title;
  final String text;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RMText(
            text: title,
            type: RMTextTypes.infoSub,
          ),
          const SizedBox(
            height: 4,
          ),
          RMText(
            text: text,
            type: RMTextTypes.infoTitle,
          ),
          if (date != null)
            const SizedBox(
              height: 4,
            ),
          if (date != null)
            RMText(
              text: date ?? '',
            ),
        ],
      ),
    );
  }
}

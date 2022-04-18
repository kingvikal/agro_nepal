import 'package:flutter/material.dart';

class ProfileData extends StatelessWidget {
  const ProfileData(
      {Key? key,
      required this.string,
      required this.showDivider,
      required this.sizedBox})
      : super(key: key);

  final String string;
  final bool showDivider;
  final bool sizedBox;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              string,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Montserrat',
              ),
            ),
            const Icon(Icons.keyboard_arrow_right_rounded)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (showDivider)
          const Divider(
            height: 2,
            thickness: 1,
            indent: 5,
            endIndent: 5,
          ),
        if (sizedBox)
          const SizedBox(
            height: 10,
          ),
      ],
    );
  }
}

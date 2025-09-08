import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_image_view.dart';

class StatItemWidget extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const StatItemWidget({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2.h,
      children: [
        Container(
          width: 36.h,
          child: CustomImageView(
            imagePath: icon,
            height: 24.h,
            width: 20.h,
          ),
        ),
        Text(
          label,
          style: TextStyleHelper.instance.label10RegularRoboto
              .copyWith(color: appTheme.gray_900_01),
        ),
        Text(
          value,
          style: TextStyleHelper.instance.title16BoldRoboto,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_image_view.dart';
import '../models/member_item_model.dart';

class MemberItemWidget extends StatelessWidget {
  final MemberItemModel memberItem;

  const MemberItemWidget({
    Key? key,
    required this.memberItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 4.h),
          child: CustomImageView(
            imagePath: memberItem.avatar ?? ImageConstant.imgUser,
            height: 48.h,
            width: 50.h,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  memberItem.name ?? 'Unknown',
                  style: TextStyleHelper.instance.title17RegularABeeZee
                      .copyWith(height: 1.24),
                ),
                Text(
                  memberItem.rank ?? 'Rank Unknown',
                  style: TextStyleHelper.instance.body14RegularInter
                      .copyWith(height: 1.21),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 21.h),
          width: 67.h,
          child: Text(
            memberItem.date ?? '00/00/0000',
            textAlign: TextAlign.right,
            style: TextStyleHelper.instance.body14RegularNATS
                .copyWith(height: 2.07),
          ),
        ),
      ],
    );
  }
}

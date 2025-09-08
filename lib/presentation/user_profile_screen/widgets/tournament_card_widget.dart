import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_image_view.dart';

class TournamentCardWidget extends StatelessWidget {
  final String ballNumber;
  final String title;
  final String date;
  final String participants;
  final String level;
  final String prize;
  final String networkCount;
  final VoidCallback? onTap;

  const TournamentCardWidget({
    Key? key,
    required this.ballNumber,
    required this.title,
    required this.date,
    required this.participants,
    required this.level,
    required this.prize,
    required this.networkCount,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 4.h),
        padding: EdgeInsets.all(4.h),
        decoration: BoxDecoration(
          color: appTheme.white_A700,
          borderRadius: BorderRadius.circular(10.h),
          border: Border.all(
            color: appTheme.color110000,
            width: 1.h,
          ),
          boxShadow: [
            BoxShadow(
              color: appTheme.color3F0000,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40.h,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.h),
                gradient: LinearGradient(
                  colors: [Color(0xFF000000), Color(0xFF000000)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.color990000,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 20.h,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: appTheme.white_A700,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  child: Center(
                    child: Text(
                      ballNumber,
                      style: TextStyleHelper.instance.body12RegularAcme,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyleHelper.instance.body14RegularABeeZee,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgSymbolCyan900,
                        height: 12.h,
                        width: 10.h,
                      ),
                      SizedBox(width: 8.h),
                      Text(
                        date,
                        style: TextStyleHelper.instance.label10RegularRoboto,
                      ),
                      SizedBox(width: 20.h),
                      CustomImageView(
                        imagePath: ImageConstant.imgSLNgThamGia,
                        height: 16.h,
                        width: 12.h,
                      ),
                      SizedBox(width: 10.h),
                      Text(
                        participants,
                        style: TextStyleHelper.instance.label10RegularRoboto
                            .copyWith(color: appTheme.red_900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 6.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16.h),
                  child: Text(
                    level,
                    style: TextStyleHelper.instance.body12RegularInter,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgDollarSign,
                      height: 12.h,
                      width: 18.h,
                    ),
                    Text(
                      prize,
                      style: TextStyleHelper.instance.label10RegularRoboto
                          .copyWith(color: appTheme.red_900),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 6.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  networkCount,
                  style: TextStyleHelper.instance.label10RegularRoboto,
                ),
                SizedBox(height: 2.h),
                Container(
                  margin: EdgeInsets.only(left: 6.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgThChUButton,
                    height: 22.h,
                    width: 44.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

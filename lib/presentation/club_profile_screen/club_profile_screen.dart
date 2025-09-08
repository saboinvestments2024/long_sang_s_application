import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_location_button.dart';
import './models/member_item_model.dart';
import './notifier/club_profile_notifier.dart';
import './widgets/member_item_widget.dart';

class ClubProfileScreen extends ConsumerStatefulWidget {
  const ClubProfileScreen({Key? key}) : super(key: key);

  @override
  ClubProfileScreenState createState() => ClubProfileScreenState();
}

class ClubProfileScreenState extends ConsumerState<ClubProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.white_A700,
        appBar: CustomAppBar(
          username: 'sabobilliards',
        ),
        body: Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(clubProfileNotifier);

            return SingleChildScrollView(
              child: Column(
                spacing: 26.h,
                children: [
                  _buildProfileSection(context, state),
                  _buildMembersList(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildProfileSection(BuildContext context, ClubProfileState state) {
    return Container(
      width: double.infinity,
      height: 542.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: appTheme.white_A700,
              boxShadow: [
                BoxShadow(
                  color: appTheme.blue_gray_100,
                  offset: Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 10.h,
              vertical: 16.h,
            ),
            child: Column(
              spacing: 22.h,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.h),
                  width: double.infinity,
                  height: 418.h,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16.h),
                        padding: EdgeInsets.symmetric(horizontal: 4.h),
                        width: double.infinity,
                        height: 350.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgClubAvatar,
                              height: 344.h,
                              width: 344.h,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.h),
                                gradient: LinearGradient(
                                  begin: Alignment(0.165, -1.0),
                                  end: Alignment(0.165, 1.0),
                                  colors: [
                                    Color(0xF8667784),
                                    appTheme.color26331B,
                                    appTheme.colorF866C6,
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(0, 0),
                                        end: Alignment(0, 1),
                                        colors: [
                                          Color(0xCC000000),
                                          appTheme.color000000,
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 43.h,
                                            bottom: 2.h,
                                          ),
                                          child: ShaderMask(
                                            shaderCallback: (bounds) =>
                                                LinearGradient(
                                              colors: [
                                                Color(0xFFA0B2F8),
                                                appTheme.indigo_300,
                                              ],
                                            ).createShader(bounds),
                                            child: Text(
                                              'SABO Billiards',
                                              style: TextStyleHelper.instance
                                                  .display50BlackAlumniSans
                                                  .copyWith(
                                                      letterSpacing: 3,
                                                      height: 1.22),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30.h),
                          child: CustomIconButton(
                            onPressed: () {
                              ref
                                  .read(clubProfileNotifier.notifier)
                                  .onEditButtonPressed();
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(left: 75.h),
                          child: CustomLocationButton(
                            text: '601A Nguyễn An Ninh - TP Vũng Tàu',
                            leftIconPath: ImageConstant.imgIconLocation,
                            onPressed: () {
                              ref
                                  .read(clubProfileNotifier.notifier)
                                  .onLocationButtonPressed();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatsSection(context, state),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 34.h,
              decoration: BoxDecoration(
                color: appTheme.white_A700,
                boxShadow: [
                  BoxShadow(
                    color: appTheme.blue_gray_100,
                    offset: Offset(0, 1),
                    blurRadius: 1,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 32.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 8.h,
                      bottom: 8.h,
                    ),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMenbersGray90004,
                      height: 26.h,
                      width: 48.h,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgTournamentsBlueGray10001,
                    height: 18.h,
                    width: 20.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgRank,
                      height: 22.h,
                      width: 20.h,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgIlllustrationBlueGray10001,
                      height: 32.h,
                      width: 32.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStatsSection(BuildContext context, ClubProfileState state) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 14.h,
        vertical: 18.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 18.h),
                child: Text(
                  state.clubProfileModel?.membersCount ?? '25',
                  style: TextStyleHelper.instance.title18BoldRoboto
                      .copyWith(height: 1.22),
                ),
              ),
              Text(
                'Thành viên',
                style: TextStyleHelper.instance.body12RegularRoboto
                    .copyWith(height: 1.25),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 18.h),
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.h),
                  child: Text(
                    state.clubProfileModel?.tournamentsCount ?? '15',
                    style: TextStyleHelper.instance.title18BoldRoboto
                        .copyWith(height: 1.22),
                  ),
                ),
                Text(
                  'Giải đấu',
                  style: TextStyleHelper.instance.body12RegularRoboto
                      .copyWith(height: 1.25),
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.clubProfileModel?.prizePool ?? '89.9 Tr',
                style: TextStyleHelper.instance.title16BoldRoboto
                    .copyWith(height: 1.19),
              ),
              Text(
                'Prize Pool',
                style: TextStyleHelper.instance.body12RegularRoboto
                    .copyWith(height: 1.25),
              ),
            ],
          ),
          Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 18.h),
                child: Text(
                  state.clubProfileModel?.challengesCount ?? '37',
                  style: TextStyleHelper.instance.title18BoldRoboto
                      .copyWith(height: 1.22),
                ),
              ),
              Text(
                'Thách đấu',
                style: TextStyleHelper.instance.body12RegularRoboto
                    .copyWith(height: 1.25),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildMembersList(BuildContext context, ClubProfileState state) {
    return Container(
      margin: EdgeInsets.fromLTRB(22.h, 0, 16.h, 24.h),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MemberItemWidget(
                  memberItem: state.membersList?[0] ?? MemberItemModel(),
                ),
                SizedBox(height: 11.h),
                Text(
                  'Joshua',
                  style: TextStyleHelper.instance.body13RegularSFProText
                      .copyWith(height: 1.23),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: appTheme.white_A700,
            ),
            padding: EdgeInsets.symmetric(horizontal: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 14.h),
                  child: MemberItemWidget(
                    memberItem: state.membersList?[1] ?? MemberItemModel(),
                  ),
                ),
                SizedBox(height: 11.h),
                Text(
                  'Joshua',
                  style: TextStyleHelper.instance.body13RegularSFProText
                      .copyWith(height: 1.23),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

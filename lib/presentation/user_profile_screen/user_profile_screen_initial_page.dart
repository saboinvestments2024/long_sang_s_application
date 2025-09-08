import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import './widgets/stat_item_widget.dart';
import './widgets/tournament_card_widget.dart';
import 'notifier/user_profile_notifier.dart';

class UserProfileScreenInitialPage extends ConsumerStatefulWidget {
  const UserProfileScreenInitialPage({Key? key}) : super(key: key);

  @override
  UserProfileScreenInitialPageState createState() =>
      UserProfileScreenInitialPageState();
}

class UserProfileScreenInitialPageState
    extends ConsumerState<UserProfileScreenInitialPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProfileNotifier);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileSection(context),
              _buildStatsSection(context),
              _buildTournamentIndicator(context),
              _buildTabSection(context),
              SizedBox(height: 10.h),
              _buildTabContent(context),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      username: 'longsang',
      onLeadingTap: () {
        // Handle leading icon tap
      },
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
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
      child: Container(
        width: double.maxFinite,
        height: 404.h,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 370.h),
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
                decoration: BoxDecoration(
                  color: appTheme.color5B2623,
                  borderRadius: BorderRadius.circular(4.h),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgContainer,
                      height: 10.h,
                      width: 10.h,
                    ),
                    SizedBox(width: 14.h),
                    Text(
                      'RANK : G',
                      style: TextStyleHelper.instance.title23SemiBoldRoboto
                          .copyWith(height: 1.22),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 350.h,
                height: 350.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgPhoto,
                      height: 344.h,
                      width: 344.h,
                      radius: BorderRadius.circular(16.h),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.h),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xF8667784),
                            appTheme.color26331B,
                            appTheme.colorF866C6,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Spacer(),
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0x00000000),
                                  appTheme.colorCC0000,
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 33.h),
                                  child: Text(
                                    'Anh Long Magic',
                                    style: TextStyleHelper
                                        .instance.display50BlackAlumniSans
                                        .copyWith(letterSpacing: 3),
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
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomIconButton(
                onPressed: () {
                  // Handle edit button tap
                },
                iconPath: ImageConstant.imgLineDesignEditLine,
                size: 52.h,
                backgroundColor: appTheme.gray_100,
                borderColor: appTheme.white_A700,
                borderWidth: 5.h,
                margin: EdgeInsets.only(bottom: 16.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final state = ref.watch(userProfileNotifier);

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 70.h, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatItemWidget(
            icon: ImageConstant.imgSymbol,
            label: 'ELO',
            value: '1485',
          ),
          StatItemWidget(
            icon: ImageConstant.imgSymbolGray90002,
            label: 'SPA',
            value: '320',
          ),
          StatItemWidget(
            icon: ImageConstant.imgSymbolGray9000224x16,
            label: 'XH',
            value: '#89',
          ),
          StatItemWidget(
            icon: ImageConstant.imgSymbolGray90001,
            label: 'TRẬN',
            value: '37',
          ),
        ],
      ),
    );
  }

  Widget _buildTournamentIndicator(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 24.h,
      margin: EdgeInsets.only(top: 6.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.maxFinite,
            height: 20.h,
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
            child: Container(
              margin: EdgeInsets.only(left: 126.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgTournaments,
                height: 18.h,
                width: 20.h,
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: EdgeInsets.only(left: 112.h),
            child: Column(
              spacing: 8.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 10.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgIlllustration,
                      height: 24.h,
                      width: 32.h,
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgMenbers,
                  height: 1.h,
                  width: 48.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 56.h, top: 10.h),
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        labelColor: appTheme.cyan_900,
        unselectedLabelColor: appTheme.blue_gray_100_01,
        labelStyle: TextStyleHelper.instance.title17RegularABeeZee,
        unselectedLabelStyle: TextStyleHelper.instance.title17RegularABeeZee,
        indicator: BoxDecoration(),
        tabs: [
          Tab(text: 'Ready'),
          Tab(text: 'Live'),
          Tab(text: 'Done'),
        ],
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    return Container(
      height: 400.h,
      child: TabBarView(
        controller: tabController,
        children: [
          _buildReadyTab(context),
          _buildLiveTab(context),
          _buildDoneTab(context),
        ],
      ),
    );
  }

  Widget _buildReadyTab(BuildContext context) {
    final state = ref.watch(userProfileNotifier);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 26.h, vertical: 10.h),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 4.h),
            child: Column(
              spacing: 22.h,
              children: [
                TournamentCardWidget(
                  ballNumber: '8',
                  title: 'SABO POOL 8 BALL',
                  date: '07/09 - Thứ 7',
                  participants: '0/16',
                  level: 'K - I+',
                  prize: '10 Million',
                  networkCount: '2 Mạng',
                  onTap: () {
                    // Handle tournament tap
                  },
                ),
                TournamentCardWidget(
                  ballNumber: '8',
                  title: 'SABO POOL 8 BALL',
                  date: '07/09 - Thứ 7',
                  participants: '0/16',
                  level: 'K - I+',
                  prize: '10 Million',
                  networkCount: '2 Mạng',
                  onTap: () {
                    // Handle tournament tap
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveTab(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Live tournaments will be displayed here',
          style: TextStyleHelper.instance.title16,
        ),
      ),
    );
  }

  Widget _buildDoneTab(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Completed tournaments will be displayed here',
          style: TextStyleHelper.instance.title16,
        ),
      ),
    );
  }
}

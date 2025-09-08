import 'package:flutter/material.dart';
import '../../core/app_export.dart';

/// Loading Shimmer Widget
/// Provides elegant shimmer loading effect for content placeholders
/// Follows Material Design 3 loading patterns
class LoadingShimmer extends StatefulWidget {
  const LoadingShimmer({
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
    this.child,
  }) : super(key: key);

  /// Width of the shimmer container
  final double? width;

  /// Height of the shimmer container
  final double? height;

  /// Border radius for the shimmer container
  final BorderRadius? borderRadius;

  /// Child widget to apply shimmer effect to
  final Widget? child;

  @override
  State<LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8.h),
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value, 0),
              colors: [
                appTheme.grey100,
                appTheme.grey200,
                appTheme.grey100,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Card Shimmer - Shimmer effect for card-like content
class CardShimmer extends StatelessWidget {
  const CardShimmer({
    Key? key,
    this.height = 120.0,
    this.width,
    this.margin,
  }) : super(key: key);

  final double height;
  final double? width;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      width: width,
      height: height,
      child: LoadingShimmer(
        borderRadius: BorderRadius.circular(12.h),
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoadingShimmer(
                width: 120.h,
                height: 16.h,
                borderRadius: BorderRadius.circular(8.h),
              ),
              SizedBox(height: 8.h),
              LoadingShimmer(
                width: double.infinity,
                height: 12.h,
                borderRadius: BorderRadius.circular(6.h),
              ),
              SizedBox(height: 4.h),
              LoadingShimmer(
                width: 200.h,
                height: 12.h,
                borderRadius: BorderRadius.circular(6.h),
              ),
              const Spacer(),
              Row(
                children: [
                  LoadingShimmer(
                    width: 60.h,
                    height: 12.h,
                    borderRadius: BorderRadius.circular(6.h),
                  ),
                  const Spacer(),
                  LoadingShimmer(
                    width: 80.h,
                    height: 12.h,
                    borderRadius: BorderRadius.circular(6.h),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// List Shimmer - Multiple card shimmers for list loading
class ListShimmer extends StatelessWidget {
  const ListShimmer({
    Key? key,
    this.itemCount = 5,
    this.itemHeight = 120.0,
  }) : super(key: key);

  final int itemCount;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CardShimmer(height: itemHeight);
      },
    );
  }
}

/// Avatar Shimmer - Circular shimmer for avatars
class AvatarShimmer extends StatelessWidget {
  const AvatarShimmer({
    Key? key,
    this.size = 40.0,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }
}

/// Stats Row Shimmer - For user/club stats loading
class StatsRowShimmer extends StatelessWidget {
  const StatsRowShimmer({
    Key? key,
    this.itemCount = 4,
  }) : super(key: key);

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(itemCount, (index) {
        return Column(
          children: [
            LoadingShimmer(
              width: 40.h,
              height: 20.h,
              borderRadius: BorderRadius.circular(4.h),
            ),
            SizedBox(height: 4.h),
            LoadingShimmer(
              width: 60.h,
              height: 12.h,
              borderRadius: BorderRadius.circular(6.h),
            ),
          ],
        );
      }),
    );
  }
}

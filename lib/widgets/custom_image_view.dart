import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../core/app_export.dart';
import '../core/utils/image_cache_manager.dart';

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (this.startsWith('http') || this.startsWith('https')) {
      if (this.endsWith('.svg')) {
        return ImageType.networkSvg;
      }
      return ImageType.network;
    } else if (this.endsWith('.svg')) {
      return ImageType.svg;
    } else if (this.startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, networkSvg, file, unknown }

/// Enhanced CustomImageView with improved caching and error handling
/// Supports placeholder, error widgets, and optimized loading
class CustomImageView extends StatelessWidget {
  CustomImageView({
    String? imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder,
    this.errorWidget,
    this.showLoadingIndicator = true,
    this.cacheManager,
  }) : imagePath = imagePath?.isNotEmpty == true ? imagePath : ImageConstant.imgImageNotFound;

  ///[imagePath] is required parameter for showing image
  final String? imagePath;

  final double? height;

  final double? width;

  final Color? color;

  final BoxFit? fit;

  final String? placeHolder;

  /// Custom error widget to show when image fails to load
  final Widget? errorWidget;

  /// Whether to show loading indicator for network images
  final bool showLoadingIndicator;

  /// Custom cache manager for network images
  final CacheManager? cacheManager;

  final Alignment? alignment;

  final VoidCallback? onTap;

  final EdgeInsetsGeometry? margin;

  final BorderRadius? radius;

  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget())
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    switch (imagePath!.imageType) {
      case ImageType.svg:
        return Container(
          height: height,
          width: width,
          child: SvgPicture.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: this.color != null
                ? ColorFilter.mode(
                    this.color ?? appTheme.transparentCustom, BlendMode.srcIn)
                : null,
          ),
        );
      case ImageType.file:
        return Image.file(
          File(imagePath!),
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
      case ImageType.networkSvg:
        return SvgPicture.network(
          imagePath!,
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
          colorFilter: this.color != null
              ? ColorFilter.mode(
                  this.color ?? appTheme.transparentCustom, BlendMode.srcIn)
              : null,
        );
      case ImageType.network:
        return CachedNetworkImage(
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          imageUrl: imagePath!,
          color: color,
          cacheManager: cacheManager ?? AppImageCacheManager.instance.cacheManager,
          placeholder: showLoadingIndicator ? (context, url) => Container(
            height: height ?? 30,
            width: width ?? 30,
            decoration: BoxDecoration(
              color: appTheme.grey100,
              borderRadius: radius,
            ),
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(appTheme.cyan_900),
                ),
              ),
            ),
          ) : null,
          errorWidget: (context, url, error) => errorWidget ?? Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: appTheme.grey100,
              borderRadius: radius,
            ),
            child: placeHolder != null 
              ? Image.asset(
                  placeHolder!,
                  height: height,
                  width: width,
                  fit: fit ?? BoxFit.cover,
                )
              : Icon(
                  Icons.image_not_supported_outlined,
                  size: (height != null && width != null) ? 
                    (height! < width! ? height! * 0.3 : width! * 0.3) : 24,
                  color: appTheme.gray_500,
                ),
          ),
        );
      case ImageType.png:
      default:
        return Image.asset(
          imagePath!,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
    }
  }
}

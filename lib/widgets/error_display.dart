import 'package:flutter/material.dart';
import '../../core/app_export.dart';

/// Error Display Widget
/// Provides consistent error UI with retry functionality
/// Supports different error types and custom actions
class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    Key? key,
    this.message,
    this.errorType = ErrorType.general,
    this.onRetry,
    this.showRetryButton = true,
    this.retryButtonText = 'Thử lại',
    this.height,
    this.width,
  }) : super(key: key);

  /// Error message to display
  final String? message;

  /// Type of error for appropriate icon and color
  final ErrorType errorType;

  /// Callback for retry action
  final VoidCallback? onRetry;

  /// Whether to show retry button
  final bool showRetryButton;

  /// Custom text for retry button
  final String retryButtonText;

  /// Container height
  final double? height;

  /// Container width
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      padding: EdgeInsets.all(24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildErrorIcon(),
          SizedBox(height: 16.h),
          _buildErrorMessage(),
          if (showRetryButton && onRetry != null) ...[
            SizedBox(height: 24.h),
            _buildRetryButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorIcon() {
    return Container(
      width: 64.h,
      height: 64.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getErrorColor().withOpacity(0.1),
      ),
      child: Icon(
        _getErrorIcon(),
        size: 32.h,
        color: _getErrorColor(),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Column(
      children: [
        Text(
          _getErrorTitle(),
          style: TextStyleHelper.instance.title18BoldRoboto.copyWith(
            color: appTheme.gray_900,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          message ?? _getDefaultErrorMessage(),
          style: TextStyleHelper.instance.body14RegularInter.copyWith(
            color: appTheme.gray_500,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRetryButton() {
    return ElevatedButton(
      onPressed: onRetry,
      style: ElevatedButton.styleFrom(
        backgroundColor: appTheme.cyan_900,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.h),
      ),
      child: Text(
        retryButtonText,
        style: TextStyleHelper.instance.title16BoldRoboto.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  IconData _getErrorIcon() {
    switch (errorType) {
      case ErrorType.network:
        return Icons.wifi_off_outlined;
      case ErrorType.server:
        return Icons.cloud_off_outlined;
      case ErrorType.notFound:
        return Icons.search_off_outlined;
      case ErrorType.permission:
        return Icons.lock_outline;
      case ErrorType.general:
        return Icons.error_outline;
    }
  }

  Color _getErrorColor() {
    switch (errorType) {
      case ErrorType.network:
        return appTheme.blue_200;
      case ErrorType.server:
        return appTheme.red_900;
      case ErrorType.notFound:
        return appTheme.gray_500;
      case ErrorType.permission:
        return appTheme.indigo_300;
      case ErrorType.general:
        return appTheme.gray_900;
    }
  }

  String _getErrorTitle() {
    switch (errorType) {
      case ErrorType.network:
        return 'Lỗi kết nối';
      case ErrorType.server:
        return 'Lỗi máy chủ';
      case ErrorType.notFound:
        return 'Không tìm thấy';
      case ErrorType.permission:
        return 'Không có quyền truy cập';
      case ErrorType.general:
        return 'Đã xảy ra lỗi';
    }
  }

  String _getDefaultErrorMessage() {
    switch (errorType) {
      case ErrorType.network:
        return 'Vui lòng kiểm tra kết nối internet và thử lại.';
      case ErrorType.server:
        return 'Máy chủ đang gặp sự cố. Vui lòng thử lại sau.';
      case ErrorType.notFound:
        return 'Nội dung bạn tìm kiếm không tồn tại.';
      case ErrorType.permission:
        return 'Bạn không có quyền truy cập nội dung này.';
      case ErrorType.general:
        return 'Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.';
    }
  }
}

/// Error types for different scenarios
enum ErrorType {
  general,
  network,
  server,
  notFound,
  permission,
}

/// Compact Error Widget for smaller spaces
class CompactErrorDisplay extends StatelessWidget {
  const CompactErrorDisplay({
    Key? key,
    this.message = 'Đã xảy ra lỗi',
    this.onRetry,
    this.textColor,
  }) : super(key: key);

  final String message;
  final VoidCallback? onRetry;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 16.h,
          color: textColor ?? appTheme.red_900,
        ),
        SizedBox(width: 8.h),
        Flexible(
          child: Text(
            message,
            style: TextStyleHelper.instance.body12RegularRoboto.copyWith(
              color: textColor ?? appTheme.gray_500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (onRetry != null) ...[
          SizedBox(width: 8.h),
          GestureDetector(
            onTap: onRetry,
            child: Text(
              'Thử lại',
              style: TextStyleHelper.instance.title16BoldRoboto.copyWith(
                color: appTheme.cyan_900,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Empty State Widget for when no data is available
class EmptyStateDisplay extends StatelessWidget {
  const EmptyStateDisplay({
    Key? key,
    this.title = 'Không có dữ liệu',
    this.message = 'Hiện tại chưa có nội dung nào.',
    this.icon = Icons.inbox_outlined,
    this.actionText,
    this.onAction,
    this.height,
  }) : super(key: key);

  final String title;
  final String message;
  final IconData icon;
  final String? actionText;
  final VoidCallback? onAction;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.all(32.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.h,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appTheme.blue_gray_100,
            ),
            child: Icon(
              icon,
              size: 40.h,
              color: appTheme.gray_500,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            title,
            style: TextStyleHelper.instance.title18BoldRoboto.copyWith(
              color: appTheme.gray_900,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: TextStyleHelper.instance.body14RegularInter.copyWith(
              color: appTheme.gray_500,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          if (actionText != null && onAction != null) ...[
            SizedBox(height: 24.h),
            OutlinedButton(
              onPressed: onAction,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: appTheme.cyan_900),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.h),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.h),
              ),
              child: Text(
                actionText!,
                style: TextStyleHelper.instance.title16BoldRoboto.copyWith(
                  color: appTheme.cyan_900,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

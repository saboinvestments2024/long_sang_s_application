// 🔧 COPILOT 2: API Exception handling
// Custom exception classes for handling API errors with proper error types

import 'package:equatable/equatable.dart';

/// Types of API exceptions
enum ApiExceptionType {
  /// Network connectivity issues
  network,
  
  /// Request timeout
  timeout,
  
  /// Server-side errors (4xx, 5xx)
  server,
  
  /// Request cancelled
  cancel,
  
  /// Authentication/authorization errors
  auth,
  
  /// Data parsing errors
  parsing,
  
  /// Unknown/unexpected errors
  unknown,
}

/// Custom API exception class
class ApiException extends Equatable implements Exception {
  /// Error message
  final String message;
  
  /// HTTP status code (if available)
  final int? statusCode;
  
  /// Type of exception
  final ApiExceptionType type;
  
  /// Additional error data
  final dynamic data;
  
  /// Original error (for debugging)
  final dynamic originalError;

  const ApiException({
    required this.message,
    this.statusCode,
    required this.type,
    this.data,
    this.originalError,
  });

  /// Factory constructor for network errors
  factory ApiException.network({
    String? message,
    dynamic originalError,
  }) {
    return ApiException(
      message: message ?? 'No internet connection. Please check your network.',
      type: ApiExceptionType.network,
      statusCode: 0,
      originalError: originalError,
    );
  }

  /// Factory constructor for timeout errors
  factory ApiException.timeout({
    String? message,
    dynamic originalError,
  }) {
    return ApiException(
      message: message ?? 'Request timeout. Please try again.',
      type: ApiExceptionType.timeout,
      statusCode: 408,
      originalError: originalError,
    );
  }

  /// Factory constructor for server errors
  factory ApiException.server({
    String? message,
    int? statusCode,
    dynamic data,
    dynamic originalError,
  }) {
    return ApiException(
      message: message ?? 'Server error occurred. Please try again.',
      type: ApiExceptionType.server,
      statusCode: statusCode,
      data: data,
      originalError: originalError,
    );
  }

  /// Factory constructor for authentication errors
  factory ApiException.auth({
    String? message,
    int? statusCode,
    dynamic originalError,
  }) {
    return ApiException(
      message: message ?? 'Authentication failed. Please login again.',
      type: ApiExceptionType.auth,
      statusCode: statusCode ?? 401,
      originalError: originalError,
    );
  }

  /// Factory constructor for parsing errors
  factory ApiException.parsing({
    String? message,
    dynamic originalError,
  }) {
    return ApiException(
      message: message ?? 'Failed to parse server response.',
      type: ApiExceptionType.parsing,
      originalError: originalError,
    );
  }

  /// Factory constructor for unknown errors
  factory ApiException.unknown({
    String? message,
    dynamic originalError,
  }) {
    return ApiException(
      message: message ?? 'An unexpected error occurred.',
      type: ApiExceptionType.unknown,
      originalError: originalError,
    );
  }

  /// Check if this is a network error
  bool get isNetworkError => type == ApiExceptionType.network;

  /// Check if this is a timeout error
  bool get isTimeoutError => type == ApiExceptionType.timeout;

  /// Check if this is a server error
  bool get isServerError => type == ApiExceptionType.server;

  /// Check if this is an auth error
  bool get isAuthError => type == ApiExceptionType.auth;

  /// Check if this is a parsing error
  bool get isParsingError => type == ApiExceptionType.parsing;

  /// Check if this is a client error (4xx)
  bool get isClientError => 
      statusCode != null && statusCode! >= 400 && statusCode! < 500;

  /// Check if this is a server error (5xx)
  bool get isInternalServerError => 
      statusCode != null && statusCode! >= 500;

  /// Get user-friendly error message
  String get userFriendlyMessage {
    switch (type) {
      case ApiExceptionType.network:
        return 'Không có kết nối mạng. Vui lòng kiểm tra kết nối internet.';
      case ApiExceptionType.timeout:
        return 'Kết nối quá chậm. Vui lòng thử lại.';
      case ApiExceptionType.auth:
        return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';
      case ApiExceptionType.server:
        if (statusCode == 404) {
          return 'Không tìm thấy dữ liệu yêu cầu.';
        } else if (statusCode == 403) {
          return 'Bạn không có quyền truy cập tính năng này.';
        } else if (isInternalServerError) {
          return 'Lỗi máy chủ. Vui lòng thử lại sau.';
        }
        return message;
      case ApiExceptionType.parsing:
        return 'Lỗi xử lý dữ liệu. Vui lòng thử lại.';
      default:
        return 'Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.';
    }
  }

  @override
  List<Object?> get props => [
        message,
        statusCode,
        type,
        data,
      ];

  @override
  String toString() {
    return 'ApiException{message: $message, statusCode: $statusCode, type: $type}';
  }
}

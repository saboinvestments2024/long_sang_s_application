// 🔧 COPILOT 2: Base repository interface
// Defines common repository operations for data access layer

import '../../core/error/api_exception.dart';

/// Generic result wrapper for repository operations
class RepositoryResult<T> {
  final T? data;
  final ApiException? error;
  final bool isSuccess;

  const RepositoryResult._({
    this.data,
    this.error,
    required this.isSuccess,
  });

  /// Create success result
  factory RepositoryResult.success(T data) {
    return RepositoryResult._(
      data: data,
      isSuccess: true,
    );
  }

  /// Create error result
  factory RepositoryResult.error(ApiException error) {
    return RepositoryResult._(
      error: error,
      isSuccess: false,
    );
  }

  /// Transform data if successful
  RepositoryResult<R> map<R>(R Function(T data) transform) {
    if (isSuccess && data != null) {
      try {
        return RepositoryResult.success(transform(data!));
      } catch (e) {
        return RepositoryResult.error(
          ApiException.parsing(
            message: 'Failed to transform data: $e',
            originalError: e,
          ),
        );
      }
    }
    return RepositoryResult.error(error!);
  }

  /// Execute action if successful
  void when({
    required Function(T data) onSuccess,
    required Function(ApiException error) onError,
  }) {
    if (isSuccess && data != null) {
      onSuccess(data!);
    } else {
      onError(error!);
    }
  }
}

/// Base repository interface
abstract class BaseRepository {
  /// Handle repository operations with error handling
  Future<RepositoryResult<T>> safeCall<T>(
    Future<T> Function() operation, {
    String? operationName,
  }) async {
    try {
      final result = await operation();
      return RepositoryResult.success(result);
    } on ApiException catch (e) {
      // Re-throw API exceptions as-is
      return RepositoryResult.error(e);
    } catch (e) {
      // Wrap unknown errors
      return RepositoryResult.error(
        ApiException.unknown(
          message: operationName != null 
              ? 'Failed to $operationName: $e'
              : 'Repository operation failed: $e',
          originalError: e,
        ),
      );
    }
  }

  /// Transform API response to domain model
  T transform<T, R>(
    R response,
    T Function(R) transformer, {
    String? operationName,
  }) {
    try {
      return transformer(response);
    } catch (e) {
      throw ApiException.parsing(
        message: operationName != null
            ? 'Failed to parse $operationName response: $e'
            : 'Failed to parse API response: $e',
        originalError: e,
      );
    }
  }

  /// Transform list of API responses to domain models
  List<T> transformList<T, R>(
    List<R> responseList,
    T Function(R) transformer, {
    String? operationName,
  }) {
    try {
      return responseList.map(transformer).toList();
    } catch (e) {
      throw ApiException.parsing(
        message: operationName != null
            ? 'Failed to parse $operationName list response: $e'
            : 'Failed to parse API list response: $e',
        originalError: e,
      );
    }
  }
}

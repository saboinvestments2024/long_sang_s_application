// 🔧 COPILOT 2: HTTP client service with Dio
// Handles API calls, request/response interceptors, and network error handling

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../config/app_config.dart';
import '../error/api_exception.dart';

class ApiService {
  static ApiService? _instance;
  static ApiService get instance => _instance ??= ApiService._();
  
  ApiService._();
  
  late final Dio _dio;
  Dio get dio => _dio;

  /// Initialize API service
  void initialize() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.baseApiUrl,
      connectTimeout: Duration(seconds: AppConfig.connectionTimeoutSeconds),
      receiveTimeout: Duration(seconds: AppConfig.receiveTimeoutSeconds),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    _setupInterceptors();
    
    if (AppConfig.enableLogging) {
      print('✅ API Service initialized');
    }
  }

  /// Setup request/response interceptors
  void _setupInterceptors() {
    // Logging interceptor (only in debug mode)
    if (AppConfig.isDebugMode && AppConfig.enableLogging) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }

    // Auth interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available
        final token = await _getAuthToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) {
        // Handle common errors
        final apiException = _handleDioError(error);
        handler.reject(DioException(
          requestOptions: error.requestOptions,
          error: apiException,
          type: error.type,
          response: error.response,
        ));
      },
    ));
  }

  /// Get authentication token
  Future<String?> _getAuthToken() async {
    try {
      // Import SupabaseService to get current session token
      // final session = SupabaseService.instance.client.auth.currentSession;
      // return session?.accessToken;
      return null; // TODO: Implement when auth is ready
    } catch (e) {
      return null;
    }
  }

  /// Handle Dio errors and convert to API exceptions
  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Connection timeout. Please check your internet connection.',
          statusCode: 408,
          type: ApiExceptionType.timeout,
        );

      case DioExceptionType.connectionError:
        return ApiException(
          message: 'No internet connection. Please check your network.',
          statusCode: 0,
          type: ApiExceptionType.network,
        );

      case DioExceptionType.badResponse:
        final response = error.response;
        return ApiException(
          message: response?.data?['message'] ?? 'Server error occurred.',
          statusCode: response?.statusCode ?? 500,
          type: ApiExceptionType.server,
          data: response?.data,
        );

      case DioExceptionType.cancel:
        return ApiException(
          message: 'Request was cancelled.',
          statusCode: 499,
          type: ApiExceptionType.cancel,
        );

      default:
        return ApiException(
          message: error.message ?? 'An unexpected error occurred.',
          statusCode: 500,
          type: ApiExceptionType.unknown,
        );
    }
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw e.error as ApiException;
    }
  }
}

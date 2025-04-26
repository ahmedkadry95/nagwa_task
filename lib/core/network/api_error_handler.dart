import 'package:dio/dio.dart';
import 'api_result.dart';

class ApiErrorHandler {
  static ApiFailure handle(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiFailure(
            'Connection Time Out',
            type: ApiErrorType.connectionTimeout,
          );

        case DioExceptionType.sendTimeout:
          return ApiFailure('Request timeout.', type: ApiErrorType.sendTimeout);

        case DioExceptionType.receiveTimeout:
          return ApiFailure(
            'Response timeout.',
            type: ApiErrorType.receiveTimeout,
          );

        case DioExceptionType.connectionError:
          return ApiFailure(
            'No internet connection.',
            type: ApiErrorType.noInternet,
          );

        case DioExceptionType.badCertificate:
          return ApiFailure(
            'Bad certificate.',
            type: ApiErrorType.badCertificate,
          );

        case DioExceptionType.cancel:
          return ApiFailure(
            'Request cancelled.',
            type: ApiErrorType.requestCancelled,
          );
        case DioExceptionType.badResponse:
          return _handleHttpStatusCode(statusCode, error);

        default:
          return ApiFailure(
            'Unexpected Dio error: ${error.message}',
            type: ApiErrorType.unknown,
          );
      }
    } else if (error is FormatException) {
      return ApiFailure('Data parsing error.', type: ApiErrorType.parsingError);
    } else {
      return ApiFailure(
        'An unexpected error occurred. Please try again later.',
        type: ApiErrorType.unknown,
      );
    }
  }

  static ApiFailure _handleHttpStatusCode(int? statusCode, DioException error) {
    switch (statusCode) {
      case 400:
        return ApiFailure('Bad request.', type: ApiErrorType.badRequest);
      case 401:
        return ApiFailure('Unauthorized.', type: ApiErrorType.unauthorized);
      case 403:
        return ApiFailure('Forbidden.', type: ApiErrorType.forbidden);
      case 404:
        return ApiFailure('Not found.', type: ApiErrorType.notFound);
      case 405:
        return ApiFailure(
          'Method not allowed.',
          type: ApiErrorType.methodNotAllowed,
        );
      case 408:
        return ApiFailure(
          'Request timeout.',
          type: ApiErrorType.requestTimeout,
        );
      case 409:
        return ApiFailure('Conflict.', type: ApiErrorType.conflict);
      case 410:
        return ApiFailure('Gone.', type: ApiErrorType.gone);
      case 415:
        return ApiFailure(
          'Unsupported media type.',
          type: ApiErrorType.unsupportedMediaType,
        );
      case 422:
        return ApiFailure(
          'Unprocessable entity.',
          type: ApiErrorType.unprocessableEntity,
        );
      case 429:
        return ApiFailure(
          'Too many requests.',
          type: ApiErrorType.tooManyRequests,
        );
      case 500:
        return ApiFailure(
          'Internal server error.',
          type: ApiErrorType.internalServerError,
        );
      case 501:
        return ApiFailure(
          'Not implemented.',
          type: ApiErrorType.notImplemented,
        );
      case 502:
        return ApiFailure('Bad gateway.', type: ApiErrorType.badGateway);
      case 503:
        return ApiFailure(
          'Service unavailable.',
          type: ApiErrorType.serviceUnavailable,
        );
      case 504:
        return ApiFailure(
          'Gateway timeout.',
          type: ApiErrorType.gatewayTimeout,
        );
      case 505:
        return ApiFailure(
          'HTTP version not supported.',
          type: ApiErrorType.httpVersionNotSupported,
        );
      default:
        return ApiFailure(
          'Unexpected server error: ${error.message}',
          type: ApiErrorType.serverError,
        );
    }
  }
}

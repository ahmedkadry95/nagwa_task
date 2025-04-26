sealed class ApiResult<T> {}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResult<T> {
  final String message;
  final ApiErrorType type;
  ApiFailure(this.message, {this.type = ApiErrorType.unknown});
}

enum ApiErrorType {
  noInternet,
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  connectionError,
  badResponse,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  methodNotAllowed,
  requestTimeout,
  conflict,
  gone,
  unsupportedMediaType,
  unprocessableEntity,
  tooManyRequests,
  internalServerError,
  notImplemented,
  badGateway,
  serviceUnavailable,
  gatewayTimeout,
  httpVersionNotSupported,
  serverError,
  parsingError,
  requestCancelled,
  badCertificate,
  unknown,
}

class Unit {
  const Unit();
}

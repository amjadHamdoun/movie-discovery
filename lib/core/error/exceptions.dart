import 'package:fh/core/utils/enums.dart';

class ServerException implements Exception {
  final ErrorType error;
  final int? statusCode;

  const ServerException(this.error,{this.statusCode});
}

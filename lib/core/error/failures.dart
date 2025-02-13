import '../utils/enums.dart';

class Failure {
  final ErrorType error;
  final int? statusCode;
  Failure(this.error,{this.statusCode});
}

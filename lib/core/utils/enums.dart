// ignore_for_file: constant_identifier_names


enum ToastType { success, error }

enum RequestMethod { get, delete, post, patch, put }

enum DeviceType {phone ,tablet ,largerDevice}



enum ErrorType {
  connectionTimeout(message: "Check Internet Connection"),
  serverError(message: "Something is wrong"),
  error(message: "Something is wrong"),
  networkError(message: "Check Internet Connection"),
  unAuthenticatedError(message:"Unauthenticated"),
  noDataFound(message: "No Data Found");
  final String message;
  const ErrorType({required this.message});
}

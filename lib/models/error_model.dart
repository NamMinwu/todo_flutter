class ErrorModel {
  final String message;

  ErrorModel.fromjson(Map<String, dynamic> json) : message = json['message'];
}

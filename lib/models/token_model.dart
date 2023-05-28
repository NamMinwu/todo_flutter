class TokenModel {
  final String token;

  TokenModel.fromjson(Map<String, dynamic> json) : token = json['access_token'];
}

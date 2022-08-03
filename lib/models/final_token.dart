import 'dart:convert';

FinalToken finalTokenFromJson(String str) =>
    FinalToken.fromJson(json.decode(str));

String finalTokenToJson(FinalToken data) => json.encode(data.toJson());

class FinalToken {
  FinalToken({
    this.token,
  });

  String? token;

  factory FinalToken.fromJson(Map<String, dynamic> json) => FinalToken(
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}

// To parse this JSON data, do
//
//     final emailDto = emailDtoFromJson(jsonString);

import 'dart:convert';

EmailDto emailDtoFromJson(String str) => EmailDto.fromJson(json.decode(str));

String emailDtoToJson(EmailDto data) => json.encode(data.toJson());

class EmailDto {
  String email;
  int id;
  String msg;
  String per;

  EmailDto({
    this.email,
    this.id,
    this.msg,
    this.per,
  });

  EmailDto copyWith({
    String email,
    int id,
    String msg,
    String per,
  }) =>
      EmailDto(
        email: email ?? this.email,
        id: id ?? this.id,
        msg: msg ?? this.msg,
        per: per ?? this.per,
      );

  factory EmailDto.fromJson(Map<String, dynamic> json) => EmailDto(
        email: json["email"] == null ? null : json["email"],
        id: json["id"] == null ? null : json["id"],
        msg: json["msg"] == null ? null : json["msg"],
        per: json["per"] == null ? null : json["per"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "id": id == null ? null : id,
        "msg": msg == null ? null : msg,
        "per": per == null ? null : per,
      };
}

// To parse this JSON data, do
//
//     final emailDto = emailDtoFromJson(jsonString);

import 'dart:convert';

EmailDto emailDtoFromJson(String str) => EmailDto.fromJson(json.decode(str));

String emailDtoToJson(EmailDto data) => json.encode(data.toJson());

class EmailDto {
  String email;
  int id;

  EmailDto({this.email, this.id});

  EmailDto copyWith({String email, int id}) => EmailDto(
        email: email ?? this.email,
        id: id ?? this.id,
      );

  factory EmailDto.fromJson(Map<String, dynamic> json) => EmailDto(
        email: json["email"] == null ? null : json["email"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "id": id == null ? null : id,
      };
}

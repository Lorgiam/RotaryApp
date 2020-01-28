// To parse this JSON data, do
//
//     final emailDto = emailDtoFromJson(jsonString);

import 'dart:convert';

EmailDto emailDtoFromJson(String str) => EmailDto.fromJson(json.decode(str));

String emailDtoToJson(EmailDto data) => json.encode(data.toJson());

class EmailDto {
    String email;

    EmailDto({
        this.email,
    });

    EmailDto copyWith({
        String email,
    }) => 
        EmailDto(
            email: email ?? this.email,
        );

    factory EmailDto.fromJson(Map<String, dynamic> json) => EmailDto(
        email: json["email"] == null ? null : json["email"],
    );

    Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
    };
}

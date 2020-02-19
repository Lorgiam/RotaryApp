// To parse this JSON data, do
//
//     final authDto = authDtoFromJson(jsonString);

import 'dart:convert';

AuthDto authDtoFromJson(String str) => AuthDto.fromJson(json.decode(str));

String authDtoToJson(AuthDto data) => json.encode(data.toJson());

class AuthDto {
    String username;
    String password;

    AuthDto({
        this.username,
        this.password,
    });

    AuthDto copyWith({
        String username,
        String password,
    }) => 
        AuthDto(
            username: username ?? this.username,
            password: password ?? this.password,
        );

    factory AuthDto.fromJson(Map<String, dynamic> json) => AuthDto(
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "password": password == null ? null : password,
    };
}

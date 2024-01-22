// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
    int id;
    String firstName;
    String lastName;
    String username;
    String email;
    String bio;
    String image;
    bool isActive;

    Profile({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        required this.bio,
        required this.image,
        required this.isActive,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        bio: json["bio"],
        image: json["image"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "bio": bio,
        "image": image,
        "is_active": isActive,
    };
}

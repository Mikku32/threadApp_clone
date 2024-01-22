// To parse this JSON data, do
//
//     final profilePosts = profilePostsFromJson(jsonString);

import 'dart:convert';

ProfilePosts profilePostsFromJson(String str) => ProfilePosts.fromJson(json.decode(str));

String profilePostsToJson(ProfilePosts data) => json.encode(data.toJson());

class ProfilePosts {
    int id;
    Owner user;
    String content;
    dynamic image;
    DateTime createdAt;
    bool isLiked;
    int likesCount;

    ProfilePosts({
        required this.id,
        required this.user,
        required this.content,
        required this.image,
        required this.createdAt,
        required this.isLiked,
        required this.likesCount,
    });

    factory ProfilePosts.fromJson(Map<String, dynamic> json) => ProfilePosts(
        id: json["id"],
        user: Owner.fromJson(json["user"]),
        content: json["content"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        isLiked: json["is_liked"],
        likesCount: json["likes_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "content": content,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "is_liked": isLiked,
        "likes_count": likesCount,
    };
}

class Owner {
    int id;
    String username;
    String image;
    String firstName;
    String lastName;

    Owner({
        required this.id,
        required this.username,
        required this.image,
        required this.firstName,
        required this.lastName,
    });

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        username: json["username"],
        image: json["image"],
        firstName: json["first_name"],
        lastName: json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "image": image,
        "first_name": firstName,
        "last_name": lastName,
    };
}

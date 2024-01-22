

import 'dart:convert';

Thread threadFromJson(String str) => Thread.fromJson(json.decode(str));

String threadToJson(Thread data) => json.encode(data.toJson());

class Thread {
    int id;
    Author user;
    String content;
    String? image;
    DateTime createdAt;
    bool isLiked;
    int likesCount;

    Thread({
        required this.id,
        required this.user,
        required this.content,
        required this.image,
        required this.createdAt,
        required this.isLiked,
        required this.likesCount,
    });

    factory Thread.fromJson(Map<String, dynamic> json) => Thread(
        id: json["id"],
        user: Author.fromJson(json["user"]),
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

class Author {
    int id;
    String username;
    String image;
    String firstName;
    String lastName;

    Author({
        required this.id,
        required this.username,
        required this.image,
        required this.firstName,
        required this.lastName,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
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

class User {
    int id;
    String firstName;
    String lastName;
    String username;
    String email;
    String bio;
    String image;
    bool? isActive;
    String? token;

    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        required this.bio,
        required this.image,
        required this.isActive,
        required this.token,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] as int,
        firstName: json["first_name"] as String,
        lastName: json["last_name"] as String,
        username: json["username"] as String,
        email: json["email"] as String,
        bio: json["bio"] as String,
        image: json["image"] as String,
        isActive: json["is_active"] as bool,
        token: json["token"] as String,
    );
}

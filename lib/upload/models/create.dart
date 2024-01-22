class Create {
  int? id;
  User? user;
  String? content;
  String? image;
  String? createdAt;
  bool? isLiked;
  int? likesCount;

  Create(
      {this.id,
      this.user,
      this.content,
      this.image,
      this.createdAt,
      this.isLiked,
      this.likesCount});

  Create.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    content = json['content'];
    image = json['image'];
    createdAt = json['created_at'];
    isLiked = json['is_liked'];
    likesCount = json['likes_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['content'] = this.content;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['is_liked'] = this.isLiked;
    data['likes_count'] = this.likesCount;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? image;
  String? firstName;
  String? lastName;

  User({this.id, this.username, this.image, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    image = json['image'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['image'] = this.image;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
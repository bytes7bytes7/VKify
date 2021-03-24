import 'dart:convert';

class User {
  final String id;
  final String name;
  final String profileImageUrl;
  final String phoneOrEmail;

  User({
    this.id,
    this.name,
    this.profileImageUrl,
    this.phoneOrEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'phoneOrEmail': phoneOrEmail,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      profileImageUrl: map['profileImageUrl'],
      phoneOrEmail: map['phoneOrEmail'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String str) => fromMap(json.decode(str));
}

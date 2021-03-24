import 'dart:convert';

class User {
  int id;
  String shortName;
  String name;
  String profileImageUrl;
  String phoneOrEmail;

  User({
    this.id=0,
    this.shortName='',
    this.name='',
    this.profileImageUrl='',
    this.phoneOrEmail='',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shortName':shortName,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'phoneOrEmail': phoneOrEmail,
    };
  }

  User fromMap(Map<String, dynamic> map) {
    return User(
      id: int.parse(map['id']),
      shortName: map['shortName'],
      name: map['name'],
      profileImageUrl: map['profileImageUrl'],
      phoneOrEmail: map['phoneOrEmail'],
    );
  }

  String toJson() => json.encode(toMap());

  User fromJson(String str) => fromMap(json.decode(str));
}

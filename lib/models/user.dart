import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String NomPrenom;
  final String photoUrl;
  final String email;
  final String userId;
  final String role;
  UserModel({
    required this.NomPrenom,
    required this.photoUrl,
    required this.email,
    required this.userId,
    required this.role,
  });

  @override
  String toString() {
    return 'UserModel(NomPrenom: $NomPrenom, photoUrl: $photoUrl, email: $email, userId: $userId, role: $role)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nometprenom': NomPrenom,
      'photourl': photoUrl,
      'email': email,
      'userid': userId,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      NomPrenom: map['nometprenom'] as String,
      photoUrl: map['photourl'] as String,
      email: map['email'] as String,
      userId: map['userid'] as String,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

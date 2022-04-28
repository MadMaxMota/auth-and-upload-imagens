import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthenticationModel {
  final bool? isValid;
  final String uid;
  final String? photoUrl;
  final String? email;
  final String? name;

  AuthenticationModel({
    required this.isValid,
    required this.uid,
    this.photoUrl,
    this.email,
    this.name,
  });

  AuthenticationModel copyWith({
    bool? isValid,
    String? uid,
    String? photoUrl,
    String? email,
    String? name,
  }) {
    return AuthenticationModel(
      isValid: isValid ?? this.isValid,
      uid: uid ?? this.uid,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isValid': isValid,
      'uid': uid,
      'photoUrl': photoUrl,
      'email': email,
      'name': name,
    };
  }

  factory AuthenticationModel.fromMap(Map<String, dynamic>? map) {
    return AuthenticationModel(
      isValid: map?['isValid'],
      uid: map?['uid'],
      photoUrl: map?['photoUrl'],
      email: map?['email'],
      name: map?['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationModel.fromJson(String source) =>
      AuthenticationModel.fromMap(
        json.decode(source),
      );

  @override
  String toString() {
    return 'AuthenticationDetail(isValid: $isValid, uid: $uid, photoUrl: $photoUrl, email: $email, name: $name,)';
  }
}

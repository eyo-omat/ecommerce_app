import 'package:flutter/material.dart';

class User {
  String id;
  String email;
  String username;
  String jwt;
  String cartId;

  User({@required this.id, @required this.email, @required this.username, @required this.jwt, @required this.cartId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      jwt: json['jwt'],
      cartId: json['cart_id']
    );
  }
}
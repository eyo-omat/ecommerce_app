import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* User actions */

ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUserData = prefs.getString('user');
  final user = storedUserData != null ? User.fromJson(json.decode(storedUserData)) : null;
  store.dispatch(GetUserAction(user));
};

class GetUserAction {
  final User _user;

  User get user => this._user;

  GetUserAction(this._user);
}

ThunkAction<AppState> getProductsAction = (Store<AppState> store) async {
  http.Response response =  await http.get('http://localhost:1337/products');
  final List<dynamic> responseData = json.decode(response.body);
  store.dispatch(GetProductsAction(responseData));
};

class GetProductsAction {
  final List<dynamic> _products;

  GetProductsAction(this._products);

  List<dynamic> get products => this._products;
}
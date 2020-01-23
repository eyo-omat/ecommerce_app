import 'dart:convert';

import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* User actions */

ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUserData = prefs.getString('user');
  final user = storedUserData != null ? json.decode(storedUserData) : null;
  store.dispatch(GetUserAction(user));
};

class GetUserAction {
  final dynamic user;

  GetUserAction(this.user);
}
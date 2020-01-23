import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/pages/login_page.dart';
import 'package:flutter_ecommerce/pages/products_page.dart';
import 'package:flutter_ecommerce/pages/register_page.dart';
import 'package:flutter_ecommerce/redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
            title: 'E-mall',
            routes: {
              '/products': (BuildContext context) => ProductsPage(),
              '/login': (BuildContext context) => LoginPage(),
              '/register': (BuildContext context) => RegisterPage(),
            },
            theme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: Colors.purple[400],
                accentColor: Colors.green[300],
                textTheme: TextTheme(
                    headline:
                        TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                    title:
                        TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                    body1: TextStyle(fontSize: 18.0))),
            home: RegisterPage()));
  }
}

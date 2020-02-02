import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/widgets/product_item.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CartPage extends StatefulWidget {

  @override
  CartPageState createState() => CartPageState();

}

class CartPageState extends State<CartPage> {
  Widget _cartTab(){
    final Orientation orientation = MediaQuery.of(context).orientation;
    return StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: SafeArea(
                    top: false,
                    bottom: false,
                    child: GridView.builder(
                      itemCount: state.cartProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: orientation == Orientation.portrait? 2:3, 
                        mainAxisSpacing: 4.0, 
                        crossAxisSpacing: 4.0,
                        childAspectRatio: orientation == Orientation.portrait ? 1.0 : 1.3,
                      ),
                      itemBuilder: (context, i) => ProductItem(item: state.cartProducts[i]),
                    ),
                  ),
                )
              ],
            );
          },
          );
  }

  Widget _cardsTab(){
    return Text('Cards');
  }

  Widget _receiptTab(){
    return Text('orders');
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart Page'),
          bottom: TabBar(
            labelColor: Colors.yellow[600],
            unselectedLabelColor: Colors.yellow[900],
            tabs: <Widget>[
              Tab(icon: Icon(Icons.shopping_cart)),
              Tab(icon: Icon(Icons.credit_card)),
              Tab(icon: Icon(Icons.receipt)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _cartTab(),
            _cardsTab(),
            _receiptTab()
          ],
        ),
      ),
    );
  }

}
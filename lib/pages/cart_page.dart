import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/redux/actions.dart';
import 'package:flutter_ecommerce/widgets/product_item.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final void Function() onInit;
  CartPage({ this.onInit });

  @override
  CartPageState createState() => CartPageState();

}

class CartPageState extends State<CartPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void initState() {
    super.initState();
    widget.onInit();
    StripePayment.setOptions(StripeOptions(publishableKey: "pk_test_CtEaZv56WAdxEZ2EgabKlF5N"));
  }
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
    return StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            _addCard(cardToken) async {
              final User user = state.user;
              // update a user's data to include cardToken (PUT /users/:id)
              await http.put('http://localhost:1337/users/${user.id}', body: {
                "card_token": cardToken
              }, headers: {
                'Authorization': 'Bearer ${user.jwt}'
              });
              // associate cardToken (added card) with stripe customer (POST /card/add)
              http.Response response = await http.post('http://localhost:1337/card/add', body: {
                "source": cardToken,
                "customer": user.customerId
              });

              final responseData = json.decode(response.body);
              return responseData;

            }
            return Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10.0)),
                RaisedButton(
                  elevation: 8.0,
                  child: Text('Add card'),
                  onPressed: () async {
                    final PaymentMethod cardPaymentMethod = await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest());
                    final String cardToken = cardPaymentMethod.id;
                    final card = await _addCard(cardToken);
                    // Action to Add card
                    StoreProvider.of<AppState>(context).dispatch(AddCardAction(card));
                    // Action to updated card token
                    StoreProvider.of<AppState>(context).dispatch(UpdateCardTokenAction(card['id']));
                    // show snackbar
                    final snackbar = SnackBar(
                      content: Text('Card Added!', style: TextStyle(color: Colors.green))
                    );
                    _scaffoldKey.currentState.showSnackBar(snackbar);
                  }
                ),
                Expanded(
                  child: ListView(
                    children: state.cards.map<Widget>((c) => (ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        child: Icon(Icons.credit_card, color: Colors.white),
                      ),
                      title: Text("${c['card']['exp_month']}/${c['card']['exp_year']}, ${c['card']['last4']}"),
                      subtitle: Text(c['card']['brand']),
                      trailing: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: Text('Set as Primary', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),),
                        onPressed: () => print('pressed'),
                      ),
                    )
                    )
                  ).toList()
                  )
                )
              ],
            );
          },
          );
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
        key: _scaffoldKey,
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
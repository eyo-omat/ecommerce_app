import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  Widget _showTitile() {
    return Text('Register', style: Theme.of(context).textTheme.headline);
  }

  Widget _showUsernameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: (val) => val.length < 6 ? 'Username is too short':null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
            hintText: 'Enter username, min length 6',
            icon: Icon(
              Icons.face,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: (val) => !val.contains('@') ? 'Invalid Email':null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter a valid email',
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: (val) => val.length < 6 ? 'Password is too short':null,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
            hintText: 'Enter password, min length 6',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showFormActions() {
    return Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          child: Text(
                            'Submit',
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Colors.black),
                          ),
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          color: Theme.of(context).primaryColor,
                          onPressed: () => _submit()
                        ),
                        FlatButton(
                          child: Text('Existing User? Login'),
                          onPressed: () => print('login'),
                        )
                      ],
                    ),
                  );
  }

  void _submit() {
    if (_formKey.currentState.validate()){
      print('form valid');
    } else{
      print('Form invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _showTitile(),
                  _showUsernameInput(),
                  _showEmailInput(),
                  _showPasswordInput(),
                  _showFormActions(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

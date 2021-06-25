import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/authentication.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = new TextEditingController();

  Map<String, dynamic> _authData = {
    'fullName': '',
    'email' : '',
    'password' : '',
  };

  //String? fullName;
  //String? email ;
  //String? password;
  //String contact = '';
  //String bank = '';
  //String ifsc = '';

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              title: Text('An Error Occured'),
              content: Text(msg),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            )
    );
  }
  Future<void> _submit() async
  {
    if(!_formKey.currentState!.validate())
      {
        return;
      }
    _formKey.currentState!.save();

    try{
      await Provider.of<Authentication>(context, listen: false).signUp(
          _authData['fullName'],
          _authData['email'],
          _authData['password'],

      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch(error)
    {
      var errorMessage = 'Authentication Failed. Please try again later';
      _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),

        actions: <Widget>[
          TextButton(
            child: Row(
              children: <Widget>[
                Text('Login'),
                Icon(Icons.person)
              ],
            ),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      Colors.greenAccent,
                    ]
                )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 550,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[


                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.person), labelText: 'Name'),
                          keyboardType: TextInputType.text,
                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                             _authData['fullName'] = value;
                          },
                        ),

                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.email), labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if (value == null || !value.contains('@'))
                            {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['email'] = value;
                          },
                        ),

                        //Password
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.lock), labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value)
                          {
                            if(value == null || value.length<=5)
                            {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['password'] = value;
                          },
                        ),

                        //Confirm Password
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.lock_open), labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value)
                          {
                            if(value == null || value !=_passwordController.text)
                            {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {

                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.phone), labelText: 'Contact No'),
                          keyboardType: TextInputType.number,
                          validator: (value)
                          {
                            if (value!.length !=10)
                            {
                              return 'Please enter correct Contact No';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {

                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.account_balance_wallet), labelText: 'Bank Account No'),
                          keyboardType: TextInputType.number,
                          validator: (value)
                          {
                            if (value == null)
                            {
                              return 'Please enter your Bank Account No';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {

                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(prefixIcon: Icon(Icons.account_balance), labelText: 'IFSC Code'),
                          keyboardType: TextInputType.text,
                          validator: (value)
                          {
                            if (value == null)
                            {
                              return 'Please enter IFSC Code';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {

                          },
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          child: Text(
                              'Submit'
                          ),
                          onPressed: ()
                          {
                            _submit();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
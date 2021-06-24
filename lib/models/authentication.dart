import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'http.exception.dart';

class Authentication with ChangeNotifier
{
  Future<void> signUp(String fullName, String email, String password) async
  {
    var url = Uri(host:'https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=AIzaSyA05TuCiFzQ9NCFYDFo5mSsYqGz6lmoaMc');
    try{
      final response = await http.post(url, body: json.encode(
         {
         'fullName' : fullName,
         'email' : email,
         'password': password,
         'returnSecureToken': true,
         }
         ));
      final responseData = json.decode(response.body);

      if(responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error)
    {
      throw error;
    }

  }

  Future<void> logIn(String email, String password) async
  {
    var url = Uri(host:'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA05TuCiFzQ9NCFYDFo5mSsYqGz6lmoaMc');

    try{
      final response = await http.post(url, body: json.encode(
          {
            'email' : email,
            'password': password,
            'returnSecureToken': true,
          }
      ));
      final responseData = json.decode(response.body);
      if(responseData['error'] != null)
        {
          throw HttpException(responseData['error']['message']);
    }
      // print(responseData);
    }catch(error){
      throw error;
    }
    final response = await http.post(url, body: json.encode(
        {
          'email' : email,
          'password': password,
          'returnSecureToken': true,
        }
    ));
    final responseData = json.decode(response.body);
    print(responseData);
  }
}
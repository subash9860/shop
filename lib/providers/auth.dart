import 'dart:convert';
// import 'dart:js';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/Screen/auth_screen.dart';
import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';

import 'package:shop/model/http_exception.dart';

class Auth with ChangeNotifier {
  String _token = '';
  // late DateTime _expiryDate;
  String _expiryDate = '';
  String _userId = '';
  // late Timer _authTimer;

  // FirebaseAuth auth = FirebaseAuth.instance;

  // FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
// FirebaseAuth auth = FirebaseAuth.instanceFor(app: secondaryApp);

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDLvtbaDZ5YlaRafRBMmS522mnceihFTpo');
    try {
      final respond = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final respondData = json.decode(respond.body);

      print(respondData);
      if (respondData['error'] != null) {
        throw HttpExpection(respondData['error']['message']);
      }
      _token = respondData['idToken'];
      _userId = respondData['localId'];
      _expiryDate = respondData['expiresIn'];

      print("\n\n Token: $_token");
      print("\n UserID: $_userId");
      print("Expriy time: $_expiryDate");

      print("isAuth:$isAuth");
      print("\n get token:$token");
      print("\n userID: $userId");

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  String? get token {
    if (_token.isNotEmpty &&
        _expiryDate.isNotEmpty &&
        DateTime.now()
            .add(Duration(seconds: int.parse(_expiryDate)))
            .isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  bool? get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  void logout(BuildContext context) async {
    // _token= null ;
    // _userId  = null;
    // _expiryDate = null;
    Navigator.pushReplacementNamed(context, AuthScreen.routeName);

    notifyListeners();
  }

  // FirebaseAuth auth = FirebaseAuth.instance;

  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // logout() async {
  // await _firebaseAuth.signOut();
  // }

  void _atuologout() {
    var time = DateTime.now().add(Duration(seconds: int.parse(_expiryDate)));
    final timeToExpiry = time.difference(DateTime.now()).inSeconds;
    // Timer(Duration(seconds: timeToExpiry), logout);
  }
}

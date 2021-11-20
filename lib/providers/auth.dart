import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/model/http_exception.dart';

class Auth with ChangeNotifier {
  String _token = '';
  // late DateTime _expiryDate;
  String _expiryDate = '';
  String _userId = '';

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
      if (respondData['error'] !=null) {
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
}

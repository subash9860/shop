import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> signup(String email, String password) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDLvtbaDZ5YlaRafRBMmS522mnceihFTpo');
    final respond = await http.post(url,
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));

    print(json.encode(respond.body));
  }
}

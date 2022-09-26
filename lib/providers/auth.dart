import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    //is true mean authenticated
    return token != null; // authenticated
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token; //authenticated
    }
    return null; //no authenticated
  }

  // Auth(this._expiryDate, this._token, this._userId);

  // Future<void> Login(String entered_email, String entered_password) async {
  //   print(entered_email);
  //   print(entered_password);

  //   final url = Uri.parse(
  //       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC7vhUZFMXmv3tnMp8PwrgSEL1u0jEx8zA');
  //   final response = await http.post(
  //     url,
  //     body: json.encode(
  //       {
  //         'email': entered_email,
  //         'password': entered_password,
  //         'returnSecureToken': true,
  //       },
  //     ),
  //   );
  //   print(response.body);
  //   // print(json.decode(response.body));
  // }

  // Future<void> Signup(String entered_email, String entered_password) async {
  //   print(entered_email);
  //   print(entered_password);
  //   final url = Uri.parse(
  //       'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyC7vhUZFMXmv3tnMp8PwrgSEL1u0jEx8zA');
  //   final response = await http.post(
  //     url,
  //     body: json.encode(
  //       {
  //         'email': entered_email,
  //         'password': entered_password,
  //         'returnSecureToken': true,
  //       },
  //     ),
  //   );
  //   print(response.body);
  //   // print(json.decode(response.body));
  // }

  //or --optimise
  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyC7vhUZFMXmv3tnMp8PwrgSEL1u0jEx8zA');

    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData = json.decode(response.body);
    //if user is already exist in sign up //at that time error occur
    /*//this is also formate  of errror
      {error: {code: 400, message: EMAIL_EXISTS, errors: [{message: EMAIL_EXISTS, domain: global, reason: invalid}]}}
       */
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
    /*
    {kind: identitytoolkit#SignupNewUserResponse,
     idToken: eyJhbGciOiJSUzI1NiIsImtpZCI6IjIxZTZjMGM2YjRlMzA5NTI0N2MwNjgwMDAwZTFiNDMxODIzODZkNTAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc2hvcC1hcHAtZjFkNmUiLCJhdWQiOiJzaG9wLWFwcC1mMWQ2ZSIsImF1dGhfdGltZSI6MTY2MzgyODA2OSwidXNlcl9pZCI6IkZUSFlpcXJwdEtPdFdveE5NR05mejB3R0R6NDIiLCJzdWIiOiJGVEhZaXFycHRLT3RXb3hOTUdOZnowd0dEejQyIiwiaWF0IjoxNjYzODI4MDY5LCJleHAiOjE2NjM4MzE2NjksImVtYWlsIjoicEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsicEBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.pVMXHDqBkIcCVcnBFG4EqewWHgSFw42adY6b5mt11DuwAnX5Mb1vlkfR_6TC6PnT1USn31B0dzrBumcq6Ldw4R4dL9SWMM8CtwqVYafajQPn9kLD-4EUO2cfsWjVbY_l72aAXUvE04txkJ1nGryL-UWNTXK4_R8oyB7m88sq_1gRECKTa9mtjInqFwekVuaBXkHJeMbSNENDsdUb8TRjDAT0hRDowVD527_ym09iqoRFRXeZ5NWeJkrE7f8ToSUpyy6qXlgiZ3MBcTOAtzzFOtgw0HqFz-fPZyG9kVyDtSyIJY8fqcQDO8SkLupjJKe4kmurhd6VdNh2Hn34H6RhRQ,
     email: p@gmail.com,
     refreshToken: AOEOulZfB<…>
    */
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(
          responseData['expiresIn'],
        ),
      ),
    );
    notifyListeners();
    
    print('login start');
    print(_token);
    print(_userId);
    print(_expiryDate);
    print(json.decode(response.body));
    print('login end');
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }
}

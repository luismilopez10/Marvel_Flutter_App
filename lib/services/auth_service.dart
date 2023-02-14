import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyC9wK29em2PLlEop4WnjLPWRSePG7iBC_4';

  final storage = FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken,
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedData = json.decode(response.body);

    if (decodedData.containsKey('idToken')) {
      // storage.write(key: 'token', value: decodedData['idToken']);
      return null;
    }

    return decodedData['error']['message'];
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken,
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedData = json.decode(response.body);

    if (decodedData.containsKey('idToken')) {
      storage.write(key: 'token', value: decodedData['idToken']);
      storage.write(key: 'email', value: decodedData['email']);
      print(decodedData['idToken']);
      return null;
    }

    return decodedData['error']['message'];
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final response = await FirebaseAuth.instance.signInWithCredential(credential);

    if (response.credential?.accessToken != null) {
      storage.write(key: 'token', value: response.credential!.accessToken);
      storage.write(key: 'email', value: googleUser.email);
      print(response.credential!.accessToken);
      return null;
    }

    return 'Error while trying to login with google';
  }

  Future logout() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
    storage.delete(key: 'token');
    storage.delete(key: 'email');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}

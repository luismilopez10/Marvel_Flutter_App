import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  String email    = '';
  String password = '';

  String _loginError = '';
  String get loginError => _loginError;
  set loginError(String value) {
    final Map<String, String> errors = {
      'EMAIL_NOT_FOUND': 'Email Not Found',
      'INVALID_PASSWORD': 'Invalid Password',
      'EMAIL_EXISTS': 'Email already exists'
    };
    _loginError = errors[value] ?? value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;  
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  
  bool isValidForm() {

    print(loginFormKey.currentState?.validate());

    print('$email - $password');

    return loginFormKey.currentState?.validate() ?? false;
  }
}

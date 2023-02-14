import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:marvel_comics/providers/providers.dart';
import 'package:marvel_comics/ui/screens/screens.dart';
import 'package:marvel_comics/services/services.dart';
import 'package:marvel_comics/theme/app_theme.dart';
import 'package:marvel_comics/ui/input_decorations.dart';
import 'package:marvel_comics/ui/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  static const String routerName = 'Register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => LoginProvider(),
        child: LoginBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.2,),
                AuthCard(
                  child: Column(children: [
                    SizedBox(height: screenSize.height * 0.02),
                    Text('SIGN UP', style: TextStyle(fontFamily: 'Marvel', fontSize: screenSize.height * 0.055),),
                    SizedBox(height: screenSize.height * 0.035),
                    _RegisterForm(),
                  ]),
                ),
                SizedBox(height: screenSize.height * 0.035),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, LoginScreen.routerName),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(AppTheme.primary.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                  child: const Text('Already have an account', style: TextStyle(fontSize: 18, color: AppTheme.marvelWhite),),
                ),
                SizedBox(height: screenSize.height * 0.05),
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _RegisterForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginProvider>(context);
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: Form(
        key: loginFormProvider.loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'user@email.com',
                labelText: 'Email',
                prefixIcon: Icons.alternate_email_outlined),
              onChanged: (value) => loginFormProvider.email = value,
              validator: (value) {
                if (value!.isEmpty) return "Email required";

                RegExp emailRegExp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

                return emailRegExp.hasMatch(value)
                  ? null
                  : 'Invalid Email';
              },
            ),
            SizedBox(height: screenSize.height * 0.025),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: '********',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline),
              onChanged: ( value ) => loginFormProvider.password = value,
              validator: (value) {
                if (value!.isEmpty) return "Password required";

                return (value.length >= 6)
                  ? null
                  : 'The password must have at least 6 characters';
              },
            ),
            SizedBox(height: screenSize.height * 0.025),
            loginFormProvider.loginError.isNotEmpty
            ? Row(
                children: [
                  const SizedBox(width: 10,),
                  const Icon(Icons.error_outline, color: AppTheme.marvelRed,),
                  const SizedBox(width: 5,),
                  Text(loginFormProvider.loginError, style: const TextStyle(color: AppTheme.marvelRed),),
                ],
              )
            : Container(),
            SizedBox(height: screenSize.height * 0.04),
            _SignUpButton(loginFormProvider),
          ],
        )
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton(this.loginFormProvider);

  final LoginProvider loginFormProvider;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: AppTheme.primary,              
      onPressed: loginFormProvider.isLoading 
        ? null 
        : () async {
          FocusScope.of(context).unfocus();
          final authService = Provider.of<AuthService>(context, listen: false);
          
          if(!loginFormProvider.isValidForm()) return;

          loginFormProvider.isLoading = true;

          final String? errorMessage = await authService.createUser(loginFormProvider.email, loginFormProvider.password);

          loginFormProvider.isLoading = false;

          if (errorMessage == null) {
            loginFormProvider.loginError = '';
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successful User Registration')));
            Navigator.pushReplacementNamed(context, LoginScreen.routerName);
            return;
          }

          loginFormProvider.loginError = errorMessage;
          print(errorMessage);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            loginFormProvider.isLoading 
              ? 'Wait'
              : 'Sign Up',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

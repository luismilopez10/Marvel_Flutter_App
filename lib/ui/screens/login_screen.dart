import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:marvel_comics/providers/providers.dart';
import 'package:marvel_comics/ui/screens/screens.dart';
import 'package:marvel_comics/services/services.dart';
import 'package:marvel_comics/theme/app_theme.dart';
import 'package:marvel_comics/ui/input_decorations.dart';
import 'package:marvel_comics/ui/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String routerName = 'Login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => LoginProvider(),
        child: LoginBackground(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.2,),
                AuthCard(
                  child: Column(children: [
                    SizedBox(height: screenSize.height * 0.02),
                    Text('LOGIN', style: TextStyle(fontFamily: 'Marvel', fontSize: screenSize.height * 0.055),),
                    SizedBox(height: screenSize.height * 0.035),
                    const _LoginForm(),
                  ]),
                ),
                SizedBox(height: screenSize.height * 0.035),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, RegisterScreen.routerName),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(AppTheme.primary.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                  child: const Text('Sign Up', style: TextStyle(fontSize: 18, color: AppTheme.marvelWhite),),
                ),
                SizedBox(height: screenSize.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

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
            _SignInButton(loginFormProvider),
            SizedBox(height: screenSize.height * 0.035),
            const _OrContinueWith(),
            SizedBox(height: screenSize.height * 0.035),
            _GoogleSignInButton(loginFormProvider),
          ],
        )
      ),
    );
  }
}

class _OrContinueWith extends StatelessWidget {
  const _OrContinueWith({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Divider(
            thickness: 1,
            color: AppTheme.marvelWhite,
          )
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Or continue with'),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: AppTheme.marvelWhite,
          )
        ),
      ],
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton(this.loginFormProvider);

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
          final favoritesService = Provider.of<FavoritesService>(context, listen: false);

          favoritesService.loadComics();
          
          if(!loginFormProvider.isValidForm()) return;

          loginFormProvider.isLoading = true;

          final String? errorMessage = await authService.login(loginFormProvider.email, loginFormProvider.password);

          loginFormProvider.isLoading = false;

          if (errorMessage == null) {
            loginFormProvider.loginError = '';
            Navigator.pushReplacementNamed(context, HomeScreen.routerName);
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
              : 'Sign In',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton(this.loginFormProvider);

  final LoginProvider loginFormProvider;

  @override
  Widget build(BuildContext context) {
    final favoritesService = Provider.of<FavoritesService>(context);
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: loginFormProvider.isLoading 
        ? null 
        : () async {
          FocusScope.of(context).unfocus();
          final authService = Provider.of<AuthService>(context, listen: false);
          
          loginFormProvider.isLoading = true;

          final errorMessage = await authService.signInWithGoogle();

          await favoritesService.loadComics();

          loginFormProvider.isLoading = false;

          if (errorMessage == null) {
            loginFormProvider.loginError = '';
            Navigator.pushReplacementNamed(context, HomeScreen.routerName);
            return;
          }

          loginFormProvider.loginError = errorMessage;
          print(errorMessage);
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.marvelWhite),
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        child: Center(child: Image.asset('assets/images/google.png', height: 80,)),
      ),
    );
  }
}

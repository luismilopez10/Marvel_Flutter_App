import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:marvel_comics/ui/screens/screens.dart';
import 'package:marvel_comics/services/services.dart';

class CheckAuthScreen extends StatelessWidget {
  static const String routerName = 'CheckAuth';

  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return const Text('');

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const LoginScreen(),
                  transitionDuration: const Duration(seconds: 0)
                ));
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___) => HomeScreen(),
                  transitionDuration: const Duration(seconds: 0)
                ));
              });
            }

            return Container();
          },
        )
      ),
    );
  }
}

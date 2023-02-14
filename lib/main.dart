import 'package:flutter/material.dart';
import 'package:marvel_comics/ui/screens/check_auth_screen.dart';
import 'package:provider/provider.dart';

import 'ui/screens/screens.dart';
import 'providers/providers.dart';
import 'share_preferences/preferences.dart';
import 'package:marvel_comics/services/services.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preferences.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode),),
      ChangeNotifierProvider(create: (_) => ComicsService(),),
      ChangeNotifierProvider(create: (_) => AuthService(),),
      ChangeNotifierProvider(create: (_) => FavoritesService(),),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: CheckAuthScreen.routerName,
      routes: {
        CheckAuthScreen.routerName: (_) => const CheckAuthScreen(),
        LoginScreen.routerName: (_) => const LoginScreen(),
        RegisterScreen.routerName: (_) => const RegisterScreen(),
        HomeScreen.routerName: (_) => HomeScreen(),
        ComicDetailsScreen.routerName: (_) => ComicDetailsScreen(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:marvel_comics/services/services.dart';
import 'package:provider/provider.dart';

import 'ui/screens/screens.dart';
import 'providers/providers.dart';
import 'share_preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode),),
      ChangeNotifierProvider(create: (_) => ComicsService(),)
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
      initialRoute: HomeScreen.routerName,
      routes: {
        LoginScreen.routerName: (_) => LoginScreen(),
        HomeScreen.routerName: (_) => const HomeScreen(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

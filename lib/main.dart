import 'package:drm25/screens/home_screen/home_screen.dart';
import 'package:drm25/screens/splash_screen.dart';
import 'package:drm25/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/custom_room.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dream-25',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: {
        MyRoutes.splashRoute: (context) => const SplashScreen(),
        MyRoutes.loginRoute: (context) => const LoginScreen(),
        MyRoutes.homeRootRoute: (context) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        final settingsUri = Uri.parse(settings.name.toString());

        if ((settings.name.toString().contains("custom_room")) &&
            (settingsUri.queryParameters['rnm']!.isNotEmpty) &&
            (settingsUri.queryParameters['rn']!.isNotEmpty)) {
          return MaterialPageRoute(
              builder: (context) => CustomRoom(
                    settingsUri.queryParameters['rnm'].toString(),
                    settingsUri.queryParameters['rn'].toString(),
                  ));
        } else {
          return null;
        }
      },
    );
  }
}

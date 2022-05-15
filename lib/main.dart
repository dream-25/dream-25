import 'package:drm25/screens/custom_room.dart';
import 'package:drm25/screens/home_screen/home_screen.dart';
import 'package:drm25/screens/splash_screen.dart';
import 'package:drm25/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        MyRoutes.rootRoute: (context) => const SplashScreen(),
        MyRoutes.splashRoute: (context) => const SplashScreen(),
        MyRoutes.homeRootRoute: (context) => const HomeScreen(),
        MyRoutes.customRoomRoute: (context) => CustomRoom("", ""),
      },
    );
  }
}

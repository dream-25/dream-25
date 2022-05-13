import 'package:flutter/material.dart';
import '/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    await Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigo.shade100,
            Colors.white,
          ],
        )),
        child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: Image.asset("assets/images/app_logo.png"),
            )),
      ),
    );
  }
}

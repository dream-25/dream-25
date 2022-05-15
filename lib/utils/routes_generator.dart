import 'package:drm25/screens/custom_room.dart';
import 'package:drm25/screens/home_screen/home_screen.dart';
import 'package:drm25/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final settingsUri = Uri.parse(settings.name.toString());

    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/user_splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/home_root':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/custom_room':
        if (settings.name.toString().contains("custom_room")) {
          return MaterialPageRoute(
              builder: (_) => CustomRoom(
                    settingsUri.queryParameters['rmn'].toString(),
                    settingsUri.queryParameters['rn'].toString(),
                  ));
        }

        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:unilever_driver/domain/controllers/map_screen_controller.dart';
import 'package:unilever_driver/screens/auth/login_screen.dart';
import 'package:unilever_driver/screens/home/map_screen.dart';
import 'package:unilever_driver/screens/splash.dart';

class AppRoutes {
  static const mainRoute = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home_screen';

  static Map<String, WidgetBuilder> routes = {
    mainRoute: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    home: (context) => const MapScreen(),
  };
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilever_driver/app/app.dart';
import 'package:unilever_driver/app/routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unilever Driver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: App.navigatorKey,
      navigatorObservers: [NavigatorObserver()],
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.mainRoute,
      onGenerateRoute: (settings) {},
      builder: (context, child) {
        return child!;
      },
    );
  }
}

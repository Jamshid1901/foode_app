import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foode_app/controller/auth_controller.dart';
import 'package:provider/provider.dart';

import 'view/pages/auth/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController())
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: SplashPage(),
      ),
    );
  }
}
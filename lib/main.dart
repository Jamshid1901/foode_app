import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foode_app/controller/app_cotroller.dart';
import 'package:foode_app/controller/auth_controller.dart';
import 'package:foode_app/controller/chat_controller.dart';
import 'package:foode_app/controller/product_controller.dart';
import 'package:foode_app/controller/user_controller.dart';
import 'package:foode_app/view/pages/home/chats_page.dart';
import 'package:foode_app/view/pages/home/product_page.dart';
import 'package:provider/provider.dart';

import 'controller/home_controller.dart';
import 'view/pages/auth/splash_page.dart';
import 'view/pages/home/categorys_page.dart';
import 'view/pages/home/home_page.dart';
import 'view/pages/product/add_product_page.dart';

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
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => UserController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => ChatController()),
        ChangeNotifierProvider(create: (context) => AppController())
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
        builder: (context,child) {
          return const MaterialApp(
            title: 'Flutter Demo',
            home: ProductListPage(),
          );
        }
      ),
    );
  }
}

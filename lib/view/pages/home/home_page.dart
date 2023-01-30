import 'package:flutter/material.dart';
import 'package:foode_app/controller/user_controller.dart';
import 'package:foode_app/view/pages/auth/splash_page.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserController>().getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
      ),
      body: context.watch<UserController>().isLoading
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(context.watch<UserController>().user?.name ?? ""),
                Text(context.watch<UserController>().user?.username ?? ""),
                Text(context.watch<UserController>().user?.phone ?? ""),
                Text(context.watch<UserController>().user?.email ?? ""),
                ElevatedButton(
                    onPressed: () {
                      context.read<UserController>().logOut(() {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const SplashPage()),
                            (route) => false);
                      });
                    },
                    child: const Text("Log out"))
              ],
            ),
    );
  }
}

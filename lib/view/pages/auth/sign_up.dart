import 'package:flutter/material.dart';
import 'package:foode_app/controller/auth_controller.dart';
import 'package:foode_app/view/component/custom_text_from.dart';
import 'package:foode_app/view/pages/auth/verfy_page.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Sign Up"),
            CustomTextFrom(
              controller: controller,
              label: "Phone",
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthController>().sendSms(controller.text, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const VerifyPage()));
                  });
                },
                child: context.watch<AuthController>().isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text("Sign up"))
          ],
        ),
      ),
    );
  }
}

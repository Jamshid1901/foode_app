import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foode_app/controller/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
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
        title: Text("Tekshirish"),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: PinFieldAutoFill(
                controller: controller,
                cursor: Cursor(color: Colors.black, enabled: true, width: 2),
                decoration: BoxLooseDecoration(
                  gapSpace: 10,
                  bgColorBuilder: FixedColorBuilder(
                    Colors.white,
                  ),
                  strokeColorBuilder: FixedColorBuilder(
                    Colors.black,
                  ),
                ),
                onCodeSubmitted: (s) {},
                onCodeChanged: (s) {},
                currentCode: "",
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<AuthController>().checkCode(controller.text);
              },
              child: Text("Check"))
        ],
      ),
    );
  }
}

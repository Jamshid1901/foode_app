import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthController extends ChangeNotifier {
  String verificationId = '';
  bool isLoading = false;


  sendSms(String phone, VoidCallback codeSend) async {
    isLoading = true;
    notifyListeners();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        print(credential.toString());
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        isLoading = false;
        notifyListeners();
        codeSend();
        this.verificationId = verificationId;

      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  checkCode(String code) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);

      var res = await FirebaseAuth.instance.signInWithCredential(credential);
      print(res.user?.displayName);
      print(res.additionalUserInfo?.isNewUser);
      print(res.additionalUserInfo?.providerId);
    } catch (e) {
      print(e);
    }
  }
}

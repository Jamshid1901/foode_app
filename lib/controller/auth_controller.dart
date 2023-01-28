import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:foode_app/controller/local_sotre/local_store.dart';
import 'package:foode_app/model/user_model.dart';

class AuthController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String verificationId = '';
  String phone = "";
  String? errorText;
  bool isLoading = false;

  Future<bool> checkPhone(String phone) async {
    try {
      var res = await firestore
          .collection("users")
          .where("phone", isEqualTo: phone)
          .get();
      if (res.docs.first != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  sendSms(String phone, VoidCallback codeSend) async {
    isLoading = true;
    errorText = null;
    notifyListeners();
    if (await checkPhone(phone)) {
      errorText =
          "bu nomer ga uje account ochilgan";
      isLoading = false;
      notifyListeners();
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {
          print(credential.toString());
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          this.phone = phone;
          isLoading = false;
          notifyListeners();
          codeSend();
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  checkCode(String code, VoidCallback onSuccess) async {
    isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);

      var res = await FirebaseAuth.instance.signInWithCredential(credential);
      isLoading = false;
      notifyListeners();
      onSuccess();
    } catch (e) {
      print(e);
    }
  }

  createUser(
      {required String name,
      required String username,
      required String password,
      required String email,
      required String gender,
      required String birth,
      required VoidCallback onSuccess}) {
    firestore
        .collection("users")
        .add(UserModel(
          name: name,
          username: username,
          password: password,
          email: email,
          gender: gender,
          phone: phone,
          birth: birth,
        ).toJson())
        .then((value) async {
      await LocalStore.setDocId(value.id);
      onSuccess();
    });
  }

  login(String phone, String password, VoidCallback onSuccess) async {
    isLoading = true;
    errorText = null;
    notifyListeners();
    try {
      var res = await firestore
          .collection("users")
          .where("phone", isEqualTo: phone)
          .get();
      if (res.docs.first["password"] == password) {
        LocalStore.setDocId(res.docs.first.id);
        onSuccess();
        isLoading = false;
        notifyListeners();
      } else {
        errorText =
            "Password xatto bolishi mumkin yoki bunaqa nomer bn sign up qilinmagan";
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      errorText =
          "Password xatto bolishi mumkin yoki bunaqa nomer bn sign up qilinmagan";
      isLoading = false;
      notifyListeners();
    }
  }
}

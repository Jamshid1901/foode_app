import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foode_app/controller/local_sotre/local_store.dart';
import 'package:foode_app/model/user_model.dart';

import '../model/chats_model.dart';

class ChatController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<UserModel> users = [];
  List<ChatsModel> chats = [];
  List listOfDocIdChats = [];
  List listOfDocIdUser = [];
  List messages = [];
  bool addUser = false;

  changeAddUser() {
    addUser = !addUser;
    notifyListeners();
  }

  getUserList() async {
    var res = await firestore.collection("users").get();
    String? userId = await LocalStore.getDocId();
    users.clear();
    listOfDocIdUser.clear();

    for (var element in res.docs) {
      if (userId != element.id) {
        users.add(UserModel.fromJson(element.data()));
        listOfDocIdUser.add(element.id);
      }
    }
    notifyListeners();
  }

  getChatsList() async {
    var res = await firestore
        .collection("chats")
        .where("ids", arrayContainsAny: [await LocalStore.getDocId()]).get();
    for (var element in res.docs) {
      int ownerIndex =
          (element.data()["ids"] as List).indexOf(await LocalStore.getDocId());
      var resUser = await firestore
          .collection("users")
          .doc((element.data()["ids"] as List)[ownerIndex == 0 ? 1 : 0])
          .get();

      chats.add(ChatsModel.fromJson(
        data: element.data(),
        resender: resUser.data(),
      ));
      listOfDocIdChats.add(element.id);
    }
    notifyListeners();
  }

  getMessages(String docId) async {
    var res = await firestore
        .collection("chats")
        .doc(docId)
        .collection("messages")
        .get();
    messages.clear();
    res.docs.forEach((element) {
      messages.add(element);
    });
    notifyListeners();
  }

  createChat(int index) async {
    await firestore.collection("chats").add({
      "ids": [listOfDocIdUser[index], await LocalStore.getDocId()]
    });
  }
}

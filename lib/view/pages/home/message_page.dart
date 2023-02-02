import 'package:flutter/material.dart';
import 'package:foode_app/controller/chat_controller.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  final String docId;
  const MessagePage({Key? key, required this.docId}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatController>().getMessages(widget.docId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state  = context.watch<ChatController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
      ),
      body: state.messages.isEmpty ? Center(child: Text("Not found")) : Center(child: Text("Siz yozishgansiz")),
    );
  }
}

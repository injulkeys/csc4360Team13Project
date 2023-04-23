import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hvu/navbar.dart';
import 'message_widget.dart';


class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messages',
      home: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: const Text('Messages'),
        ),
        body: MessageWidget(),
      ),
    );
  }
}
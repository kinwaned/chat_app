import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_app/constants.dart';
import 'package:elearning_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chat_bubble.dart';
import '../models/message.dart';

class ChatPage extends StatelessWidget {
  static String id = 'chat page';

  final _controller = ScrollController();
  List<Message> messagesList = [];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.grey[300],
        title: Text(
          'Chat',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Icon(Icons.phone),
          SizedBox(
            width: 5,
          ),
          Icon(Icons.more_vert),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList = BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBubble(
                      message: messagesList[index],
                      isSender: true,
                    )
                        : ChatBubble(
                      message: messagesList[index],
                      color: Colors.amber,
                      isSender: false,
                    );
                  },
                );
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.image_rounded),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      BlocProvider.of<ChatCubit>(context).sendMessage(message: data, email: email);
                      controller.clear();
                      _controller.animateTo(0,
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeIn);
                    },
                    // keyboardType: TextInputType.multiline,
                    // maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';
import '../../models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());


  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessageController);
  List<Message> messagesList = [];
  void sendMessage({required String message, required String email}) {
   try {
     print('there was an error');
     messages.add({kMessage: message, kCreatedAt: DateTime.now(), 'id': email,});
   } on Exception catch (e){
     print(e);
   }
  }

  void receiveMessage() {

    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs){
        messagesList.add(Message.fromJason(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}

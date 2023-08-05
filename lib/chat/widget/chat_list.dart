import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:whatsapp_clone/chat/widget/sender_msg_card.dart';
import '../../jsonList/message_list.dart';
import 'my_message_card.dart';

// a widget that shows chat messages
class ChatList extends StatefulWidget {
  static const routeName = '/chat-list-screen';
  final String receiverUserId;
  const ChatList(this.receiverUserId, {super.key});

  @override
  State<ChatList> createState() => _ChatList();
}

class _ChatList extends State<ChatList> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    //disposing scroll controller
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
//ScrollController is used to scroll down to bottom of the screen to show latest messages
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position
          .maxScrollExtent); //scroll to max which is the latest message
    });

    return ListView.builder(
        controller: scrollController,
        itemCount: messageList.length,
        itemBuilder: (context, index) {
          final messageData = messageList[index]['data'].toString();
          var timeSent = messageList[index]['timeSent'].toString();

          //checking if the message is send by user or the sender
          //if it is by the user then the message is shown in MyMessageCard
          //or else in SenderMessageCard
          if (messageList[index]['senderId'] == "me") {
            return MyMessageCard(
              message: messageData,
              date: timeSent,
            );
          }
          return SenderMessageCard(
            message: messageData,
            date: timeSent,
          );
        });
  }
}

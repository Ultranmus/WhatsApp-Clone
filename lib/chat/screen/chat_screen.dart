import 'package:flutter/material.dart';
import '../../jsonList/user_list.dart';
import '../../widgets/colors.dart';
import '../widget/bottom_chat_field.dart';
import '../widget/chat_list.dart';

// Chat screen
class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat-screen';
  final String name;
  final String uid;
  final int index;
  const ChatScreen(
      {super.key, required this.name, required this.uid, required this.index});

  @override
  Widget build(BuildContext context) {
    //making a variable to check if user is online or offline
    var isOnline = userList[index]['isOnline'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  NetworkImage(userList[index]['imageUrl'].toString()),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white),
                ),

                //texting that show if other user is online or offline by checking condition
                Text(
                  isOnline == true ? 'online' : 'offline',
                  style: TextStyle(
                    fontSize: 13,

                    //show green color text if other user is online
                    color: isOnline == true ? Colors.green : Colors.white60,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.video_call,
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call, color: Colors.grey),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.grey),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('lib/assets/images/chat_background_image.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Expanded(
              //widget that shows existing messages
              child: ChatList(uid),
            ),
            Container(
              margin: const EdgeInsets.all(0),

              //widget for bottom textField for sending messages
              child: BottomChatField(
                receiverUserId: uid,
              ),
            )
          ],
        ),
      ),
    );
  }
}

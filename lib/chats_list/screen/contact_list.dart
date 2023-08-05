import 'package:flutter/material.dart';
import 'package:whatsapp_clone/chat/screen/chat_screen.dart';
import 'package:whatsapp_clone/jsonList/user_list.dart';
import '../../jsonList/message_list.dart';
import '../../widgets/colors.dart';

//Contact list containing existing chats
class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                      onTap: () {
                        //on contact list item click, navigates to Chat Screen with other user name,uid and index
                        //index is used because we are getting user data from userList but in future when we use database we can fetch user data by their uid and index will not be used
                        Navigator.pushNamed(context, ChatScreen.routeName,
                            arguments: {
                              'name': userList[index]["name"],
                              'uid': userList[index]["uid"],
                              'index': index
                            });
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                userList[index]["imageUrl"].toString(),
                              ),
                              radius: 30,
                            ),
                            title: Text(
                              userList[index]["name"].toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),

                              //getting last message from the messageList containing in a chat
                              //because we are using messageList for all chats, so last message will be same for all item in contacts list
                              //in future when we use database we can fetch last message from the chat using uid of other user
                              child: Text(
                                messageList[messageList.length - 1]['data']
                                    .toString(),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            trailing: Text(
                              messageList[messageList.length - 1]['timeSent']
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                          ))),
                  const Divider(
                    color: dividerColor,
                  )
                ],
              );
            }),
      ),
    );
  }
}

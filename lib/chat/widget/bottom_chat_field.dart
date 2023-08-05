import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils.dart';
import '../../widgets/colors.dart';
import 'bottom_sheet.dart';

class BottomChatField extends StatefulWidget {
  //receiverUserId is needed for sending message in future when sending message will be possible
  final String receiverUserId;
  const BottomChatField({
    required this.receiverUserId,
    super.key,
  });

  @override
  State<BottomChatField> createState() => _BottomChatField();
}

class _BottomChatField extends State<BottomChatField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isShowSendButton = false;
  final _messageController = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 400),
    );
  }

  //function to open audio
  void openAudio() async {
    //checking if mic permission is allowed
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed');
    }
//if permission is allowed then we open the audio recorder and set the isRecorderInit variable to true
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendTextMessage() async {
    if (isShowSendButton) {
//send text message function
    } else {
      //now we are getting the audio path in the directory
      var tempDirectory = await getTemporaryDirectory();
      var path = '${tempDirectory.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }

      //if audio is recording and then the button is clicked then we stop recording and send the audio file to receiverUserId
      if (isRecording) {
        await _soundRecorder!.stopRecorder();
        sendFileMessage(File(path));
      }
      //else if audio is not recording and send button is clicked then we start recording
      else {
        await _soundRecorder!.startRecorder(toFile: path);
      }

      //and setting the variable value to its opposite
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  //function to send file of any type audio,video,docs
  void sendFileMessage(
    File file,
  ) {
    //can write function to send file message to receiverUserId
  }

  //function to select image from gallery and send it
  void selectImage() async {
    File? image = await pickImageGallery(context);
    if (image != null) {
      sendFileMessage(image);
    }
  }

  //function to select video from gallery and send it
  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video);
    }
  }

  //function to select gif from Giphy and send it
  void selectGIF() async {
    final gif = await pickGIF(context);
    if (gif != null) {
      //can write function to send file to giphy
      //gif.url is not the actual url and we can not send the url directly we need to edit the url as described by giphy
    }
  }

  //function to hide Emoji Container
  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  //function to show Emoji Container
  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  //function to show soft input keyboard
  void showKeyboard() => focusNode.requestFocus();

  //function to hide soft input keyboard
  void hideKeyboard() => focusNode.unfocus();

  //function that hide keyboard if emoji container is visible and vice versa
  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messageController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 5, left: 5, bottom: 5),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  onTap: hideEmojiContainer,
                  focusNode: focusNode, //for keyboard focus
                  controller: _messageController,
                  onChanged: (val) {
                    //if the text filed is empty we send audio button and if text field is not empty we show send button
                    if (val.isNotEmpty) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    } else {
                      setState(() {
                        isShowSendButton = false;
                      });
                    }
                  },
                  cursorColor: Colors.greenAccent,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: mobileChatBoxColor,
                    prefixIcon: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            //on emoji button clicked we call the toggleEmojiKeyboardContainer function
                            onPressed: toggleEmojiKeyboardContainer,
                            icon: const Icon(Icons.emoji_emotions,
                                color: Colors.grey),
                          ),
                          IconButton(
                            onPressed: selectGIF,
                            icon: const Icon(Icons.gif, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    hintStyle: const TextStyle(color: Colors.white38),
                    hintText: 'Type a message',
                    suffixIcon: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.camera_alt,
                                color: Colors.grey),
                          ),
                          IconButton(
                            onPressed: () {
                              //calling in-built showModalBottomSheet() for a bottom pop up menu
                              showModalBottomSheet(
                                  //setting custom transition using controller
                                  transitionAnimationController: _controller,
                                  backgroundColor: Colors.transparent,
                                  context: context,

                                  //calling bottom sheet widget
                                  builder: (builder) => bottomSheet(context));
                            },
                            icon: const Icon(Icons.attach_file,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: messageColor,
                  child: GestureDetector(
                    onTap: sendTextMessage,
                    child: Icon(
                      // we show different icon like send ,audio and close for different situation like send when textField is not empty, audio when textField is empty and close when audio is recording
                      isShowSendButton
                          ? Icons.send
                          : isRecording
                              ? Icons.close
                              : Icons.mic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //it show emoji container if isShowEmojiContainer is true else show a empty sized box
        isShowEmojiContainer
            ? SizedBox(
                height: 250,
                child: EmojiPicker(
                  //on select of emoji it appends emoji in textField and if textField is empty it also set the set button icon
                  onEmojiSelected: ((category, emoji) {
                    setState(() {
                      _messageController.text =
                          _messageController.text + emoji.emoji;
                    });

                    if (!isShowSendButton) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    }
                  }),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

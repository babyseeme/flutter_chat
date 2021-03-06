import 'package:chat_demo/Model/chatModel.dart';
import 'package:chat_demo/Model/chatRecordModel.dart';
import 'package:chat_demo/Provider/chatRecordsProvider.dart';
import 'package:chat_demo/Provider/goSocketProvider.dart';
import 'package:chat_demo/Provider/signalRProvider.dart';
import 'package:chat_demo/Provider/voiceRecordProvider.dart';
import 'package:chat_demo/Tools/StaticMembers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'chatRow.dart';
import 'imageRecordRow.dart';
import 'locationRecordRow.dart';
import 'textRecordRow.dart';
import 'voiceRecordRow.dart';

class ChatDetailList extends StatelessWidget {
  const ChatDetailList({Key key, @required this.chatProvider})
      : super(key: key);
  final GoSocketProvider chatProvider;
  @override
  Widget build(BuildContext context) {
    ChatRecordsProvider recordsProvider=Provider.of<ChatRecordsProvider>(context);
    String ava1 =
        'https://pic2.zhimg.com/v2-d2f3715564b0b40a8dafbfdec3803f97_is.jpg';
    String ava2 =
        'https://pic4.zhimg.com/v2-0edac6fcc7bf69f6da105fe63268b84c_is.jpg';

    List<ChatModel> records=recordsProvider.chats;
    // records.add(ChatRecord(avatarUrl: ava1, sender: 0, content: "你吃了么？"));
    // records.add(ChatRecord(avatarUrl: ava2, sender: 1, content: "没吃呢"));
    // records.add(ChatRecord(avatarUrl: ava1, sender: 0, content: "那快去吃饭吧！"));
    // records.add(ChatRecord(
    //     avatarUrl: ava2,
    //     sender: 1,
    //     content: "原来你不请我吃饭啊 \n 我还在这等你呢 \n 1231231231"));
    VoiceRecordProvider voiceRecordProvider =
        Provider.of<VoiceRecordProvider>(context);
    return ListView.builder(
      reverse: true,
      itemCount: records.length,
      itemBuilder: (context, index) {
        if (records[index].contentModel.contentType == CHATTYPE.TEXT) {
          return TextRecordRow(
            record: records[index],
          );
        } else if (records[index].contentModel.contentType == CHATTYPE.VOICE) {
          return VoiceRecordRow(
            voiceRecordProvider: voiceRecordProvider,
            record: records[index],
          );
        } else if (records[index].contentModel.contentType == CHATTYPE.LOCATION) {
          return LocationRecordRow(record: records[index],);
        } 
        else if (records[index].contentModel.contentType==CHATTYPE.IMAGE){
          return ImageRecordRow(record: records[index],);
        }
        else {
          return Container();
        }
      },
    );
  }
}

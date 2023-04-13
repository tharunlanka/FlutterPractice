import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice/widgets/ChatBubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

    @override
    Widget build(BuildContext context) {
      var index =1;
      return Scaffold(
        appBar: AppBar(title:const  Text('Chats'),),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/WJtXsfXnb4iRu38sDbEM/messages')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = streamSnapshot.data?.docs;
            return ListView.builder(
              itemCount: documents?.length,
              itemBuilder: (ctx, index) =>
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ChatBubble(text:documents![index]['text'],isCurrentUser: true,),
                  ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            index++;
            FirebaseFirestore.instance
                .collection('chats/WJtXsfXnb4iRu38sDbEM/messages')
                .add({'text': 'message $index'});
          },
        ),
      );
    }}
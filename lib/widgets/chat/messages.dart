import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder:
          (BuildContext context, AsyncSnapshot<FirebaseUser> futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final chatDocs = chatSnapshot.data.documents;

            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (BuildContext context, int index) {
                return MessageBubble(
                  chatDocs[index]['text'],
                  chatDocs[index]['userId'] == futureSnapshot.data.uid,
                  key: ValueKey(chatDocs[index].documentID),
                );
              },
            );
          },
        );
      },
    );
  }
}

import 'package:chat_pfe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_pfe/Util/KColors.dart';
import 'package:chat_pfe/Widget/Msg.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    print(firebaseUser.uid);
    return Container(
      child: Scaffold(
        backgroundColor: KColors.primary,
        body: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection("Chat")
              .where("cparts", arrayContains: firebaseUser.uid)
              .orderBy("clastdate", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.none ||
                snapshot.data.documents.length == 0) {
              return Center(
                  child: Text("No chats yet",
                      style: TextStyle(color: KColors.fourth)));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Text("Loading..",
                      style: TextStyle(color: KColors.fourth)));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, position) {
                  return Msg(
                    doc: snapshot.data.documents[position],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thunder_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'message_bubble.dart';

FirebaseUser loggedInUser;
final _firestore = Firestore.instance;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;

  //For Database
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              messagesStream();
              _auth.signOut();
              Navigator.pop(context);
            },
          )
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('messages')
                .orderBy('time', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                );
              }
              final messages = snapshot.data.documents.reversed;
              List<MessageBubble> messageWidgets = [];
              for (var message in messages) {
                final messageText = message.data['text'];
                final messageSender = message.data['sender'];

                final currentUser = loggedInUser.email;

                final messageWidget = MessageBubble(
                  sender: messageSender,
                  text: messageText,
                  time: Timestamp.now(),
                  isMe: currentUser == messageSender,
                );
                messageWidgets.add(messageWidget);
              }
              return Expanded(
                  child: ListView(
                reverse: true,
                children: messageWidgets,
              ));
            },
          ),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore.collection('messages').add({
                      'text': messageText,
                      'sender': loggedInUser.email,
                      'time': Timestamp.now(),
                    });
                  },
                  child: Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

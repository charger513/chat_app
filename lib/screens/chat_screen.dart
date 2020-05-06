import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Text('This works!'),
          );
        },
      ),
    );
  }
}

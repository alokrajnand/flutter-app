import 'package:flutter/material.dart';

class SamajTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: Text(
                'We are trying to build a society that produce and consume localy'),
          ),
          Card(
            child: Text('be a member to either produce or consume'),
          ),
        ],
      ),
    );
  }
}

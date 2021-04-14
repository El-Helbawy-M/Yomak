import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AvatarsScreen extends StatefulWidget {
  AvatarsScreen({Key key}) : super(key: key);

  @override
  _AvatarsScreenState createState() => _AvatarsScreenState();
}

class _AvatarsScreenState extends State<AvatarsScreen> {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User newUser;
  @override
  void initState() {
    newUser = _auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          50,
          (index) => GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              await _db
                  .collection('Users')
                  .doc(newUser.email)
                  .update({'avatar' : 'images/avatar (${index + 1}).png'});
            },
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                child: Image(
                  image: AssetImage('images/avatar (${index + 1}).png'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

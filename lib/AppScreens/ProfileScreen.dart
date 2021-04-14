import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:yomak/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../AppCompenents.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      backgroundColor: Colors.yellow[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 230,
              color: Colors.grey[600],
              child: ProfileIcon(),
            ),
          ),
          SizedBox(height:50),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'AS'),
            child: ListTile(
              leading: Icon(Icons.person,color: Colors.white,),
              title: Text('Chose Avatar', style: kGreyColorStyle),
            ),
          ),
          Divider(thickness: 1,),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'CS'),
            child: ListTile(
              leading: Icon(Icons.category,color: Colors.white,),
              title: Text('Change Categories', style: kGreyColorStyle),
            ),
          ),
          Divider(thickness: 1,),
          InkWell(
            onTap: () {
              _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(context, 'WS', (Route<dynamic> route) => false);
            },
            child: ListTile(
              leading: Icon(Icons.exit_to_app,color: Colors.white,),
              title: Text('Login out', style: kGreyColorStyle),
            ),
          ),
          Divider(thickness: 1,),
        ],
      ),
    );
  }
}

// clipper: OvalBottomBorderClipper(),
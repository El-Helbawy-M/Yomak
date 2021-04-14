import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yomak/AppCompenents.dart';
import 'package:yomak/DataFuncations/FireBaseAuth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username, email, password;
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  User newUser;
  @override
  void initState() {
    newUser = FirebaseAuth.instance.currentUser;
    if (newUser != null) FirebaseAuth.instance.signOut();
    super.initState();
  }
  getCategoriesList(User newUser) async{
    categoriesList.clear();
    await for (var snapshot in _db.collection('Categories').snapshots()){
      for (var docs in snapshot.docs){
        if (docs.id == newUser.email) {
          for(var key in docs.data().keys){
            categoriesList.addAll({key : docs.data()[key]});
          }
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 50,),
            Container(
              height: 200,
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: AssetImage("images/appIcon.jpg"),fit: BoxFit.fill)),
                ),
              ),
            ),
            RoundedField(
              icon: Icons.email,
              label: 'Email',
              hint: 'Enter your Email',
              bordtype: TextInputType.emailAddress,
              onChanged: (ema) {
                setState(() => email = ema);
              },
            ),
            RoundedField(
              icon: Icons.lock,
              label: 'Password',
              hint: 'Enter your Password',
              secure: true,
              onChanged: (pass) {
                setState(() => password = pass);
              },
            ),
            SizedBox(
              height: 50,
            ),
            Hero(
              tag: 'ani',
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                height: 70,
                width: 300,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  color: Colors.grey[800],
                  onPressed: () async {
                    try {
                      final loginUser = await loginAccount(
                        email: email,
                        password: password,
                      );
                      if (loginUser != null) {
                        getCategoriesList(_auth.currentUser);
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'NS', (Route<dynamic> route) => false);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

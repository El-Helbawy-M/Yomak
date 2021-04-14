import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yomak/AppCompenents.dart';
import 'package:yomak/DataFuncations/CloudFirestore.dart';
import 'package:yomak/DataFuncations/FireBaseAuth.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String username, email, password;
  bool _saving = false;
  User newUser;
  @override
  void initState() {
    newUser = FirebaseAuth.instance.currentUser;
    if (newUser != null) FirebaseAuth.instance.signOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        isLoading: _saving,
        child: SafeArea(
          child: ListView(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    child: Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("images/appIcon.jpg"),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                  RoundedField(
                    onChanged: (name) {
                      setState(() => username = name);
                    },
                    icon: Icons.person,
                    label: 'Username',
                    hint: 'Enter your username',
                  ),
                  RoundedField(
                    onChanged: (ema) {
                      setState(() => email = ema);
                    },
                    icon: Icons.email,
                    label: 'Email',
                    hint: 'Enter your Email',
                    bordtype: TextInputType.emailAddress,
                  ),
                  RoundedField(
                    onChanged: (pass) {
                      setState(() => password = pass);
                    },
                    icon: Icons.lock,
                    label: 'Password',
                    hint: 'Enter your Password',
                    secure: true,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Hero(
                    tag: 'ani',
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      height: 70,
                      width: 300,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        color: Colors.grey[800],
                        onPressed: () async {
                          try {
                            final newuser = await createAccount(
                              email: email,
                              password: password,
                            );
                            if (newuser != null) {
                              _saving = false;
                              await addNewUserData(
                                  email: email,
                                  username: username,
                                  avatar: null);
                              setState(() {
                                categoriesList = {
                                  'Business': 'business',
                                  'Entertainment': 'entertainment',
                                  'General': 'general',
                                  'Health': 'health',
                                };
                              });
                              await addNewUsercategory(id: email);
                              Navigator.pushReplacementNamed(
                                context,
                                'CS',
                              );
                            } else
                              setState(() {
                                _saving = true;
                              });
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text(
                          'REGISTER',
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
            ],
          ),
        ),
      ),
    );
  }
}

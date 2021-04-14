import 'package:flutter/material.dart';
import 'package:yomak/AppConstants.dart';


class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/WelcomeWallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height / 3),
                Text(
                  'WELCOME',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
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
                      onPressed: () => Navigator.pushNamed(context, 'RS'),
                      child: Text(
                        'GET STARTED',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HAVE AN ACCOUNT ? ',
                      style: kMainTextStyle.copyWith(color: Colors.white),
                    ),
                    InkWell(
                      child: Text(
                        'SIGN IN',
                        style: kMainTextStyle.copyWith(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () => Navigator.pushNamed(context, 'LS'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

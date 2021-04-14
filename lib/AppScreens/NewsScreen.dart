import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yomak/AppCompenents.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:yomak/AppConstants.dart';


class NewsScreen extends StatefulWidget {
  NewsScreen({Key key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _page;
  String url , value;
  bool check = true;
  @override
  void initState() {
    _page = 1;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton:
      //     (_page == 1) ? mainFloatActionButton(context) : null,
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(seconds: 1),
        color: Colors.grey[900],
        backgroundColor: Colors.grey[200],
        buttonBackgroundColor: Colors.yellow[800],
        items: [
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.star, size: 30, color: Colors.white),
          Icon(Icons.trending_up, size: 30, color: Colors.white),
        ],
        onTap: (index) async {
          setState(() {
            _page = index;
            (_page != 1) ? check = false : check = true;
          });
        },
      ),
      body: bodies['body$_page'],
    );
  }
}


// (check)
// ? AppBar(
// elevation: (_page == 2) ? 2 : 0,
// backgroundColor: Colors.white,
// actions: <Widget>[
// IconButton(
// iconSize: 40,
// icon: Icon(Icons.filter_list, color: Colors.grey),
// onPressed: () {
// setState(() {
// showdialog(context);
// });
// },
// ),
// Hero(
// tag: 'pro',
// child: GestureDetector(
// onTap: () => Navigator.pushNamed(context, 'PS'),
// child: UserAvatar(),
// ),
// ),
// SizedBox(width: 10,),
// ],
// )
// : null
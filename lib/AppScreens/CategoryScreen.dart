import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yomak/AppConstants.dart';
import 'package:yomak/AppCompenents.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with TickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  User newUser;
  @override
  void initState() {
    newUser = _auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
              child: Container(
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              color: Colors.white,
              height: 70,
              width: double.infinity,
              child: Center(
                child: StreamBuilder<QuerySnapshot>(
                    stream: _db.collection('Categories').snapshots(),
                    builder: (context, snapshot) {
                      List<Widget> categories = [];
                      if (snapshot.hasData) {
                        categories = [];
                        final documents = snapshot.data.docs;
                        for (var doc in documents) {
                          if (doc.id == newUser.email) {
                            for (var val in doc.data().keys) {
                              categories.add(
                                SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: Category(
                                      icon: kCategoryIcons[categoriesList[val]],
                                      iconcolor: Colors.white,
                                      text: val,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        }
                        return Center(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: categories,
                          ),
                        );
                      } else
                        return CupertinoActivityIndicator();
                    }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Choose your favorite subject',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                                stream:
                                    _db.collection('Categories').snapshots(),
                                builder: (context, snapshot) {
                                  Map checkList;
                                  if (snapshot.hasData) {
                                    final documents = snapshot.data.docs;
                                    for (var docs in documents) {
                                      if (docs.id == newUser.email) {
                                        checkList = docs.data();
                                      }
                                    }
                                    return Expanded(
                                      child: ListView(
                                        children: <Widget>[
                                          CategoryCheck(
                                            id: newUser.email,
                                            value: (checkList['Technology'] !=
                                                null),
                                            cat: 'Technology',
                                            cName: 'technology',
                                          ),
                                          CategoryCheck(
                                            id: newUser.email,
                                            value:
                                                (checkList['Business'] != null),
                                            cat: 'Business',
                                            cName: 'business',
                                          ),
                                          CategoryCheck(
                                            id: newUser.email,
                                            value:
                                                (checkList['Entertainment'] !=
                                                    null),
                                            cat: 'Entertainment',
                                            cName: 'entertainment',
                                          ),
                                          CategoryCheck(
                                            id: newUser.email,
                                            value:
                                                (checkList['General'] != null),
                                            cat: 'General',
                                            cName: 'general',
                                          ),
                                          CategoryCheck(
                                            id: newUser.email,
                                            value:
                                                (checkList['Health'] != null),
                                            cat: 'Health',
                                            cName: 'health',
                                          ),
                                          CategoryCheck(
                                            id: newUser.email,
                                            value:
                                                (checkList['Sports'] != null),
                                            cat: 'Sports',
                                            cName: 'sports',
                                          ),
                                          CategoryCheck(
                                            id: newUser.email,
                                            value:
                                                (checkList['Science'] != null),
                                            cat: 'Science',
                                            cName: 'science',
                                          ),
                                        ],
                                      ),
                                    );
                                  } else
                                    return CupertinoActivityIndicator();
                                }),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              height: 70,
                              width: 300,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                color: Colors.grey[800],
                                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                    context, 'NS', (Route<dynamic> route) => false),
                                child: Text(
                                  'NEXT',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Category(
//                             icon: Icons.toys,
//                             iconcolor: Colors.white,
//                             text: 'Entertainment',
//                           ),
//                           Text('Entertainment'),
//                         ],
//                       ),
//                     ),

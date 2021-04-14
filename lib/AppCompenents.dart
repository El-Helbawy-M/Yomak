import 'dart:convert';
import 'package:loading_animations/loading_animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yomak/AppConstants.dart';
import 'package:yomak/AppScreens/ContentScreen.dart';
import 'package:yomak/DataFuncations/API.dart';
import 'package:yomak/DataFuncations/CloudFirestore.dart';

class RoundedField extends StatelessWidget {
  const RoundedField({
    this.bordtype,
    this.secure,
    this.hint,
    this.icon,
    this.label,
    this.onChanged,
  });
  final hint, label, icon, bordtype, secure, onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      child: TextField(
        onChanged: onChanged,
        obscureText: (secure != null) ? secure : false,
        keyboardType: (bordtype != null) ? bordtype : TextInputType.text,
        decoration: kTextFieldMainDecoration.copyWith(
          prefixIcon: Icon(
            icon,
            color: Colors.yellow[700],
          ),
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}

var categoriesList = {
  'Business': 'business',
  'Entertainment': 'entertainment',
  'General': 'general',
  'Health': 'health',
};

class Category extends StatelessWidget {
  const Category({this.iconcolor, this.icon, this.onPressed, this.text});
  final icon, iconcolor, onPressed, text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color:
            (iconcolor == Colors.yellow[800]) ? Colors.white : Colors.grey[800],
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color:
              (iconcolor == Colors.yellow[800]) ? iconcolor : Colors.grey[800],
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: iconcolor),
        onPressed: onPressed,
      ),
    );
  }
}

class CategoryCheck extends StatefulWidget {
  const CategoryCheck({this.cName, this.icon, this.id, this.value, this.cat});
  final icon, cName, id, value, cat;

  @override
  _CategoryCheckState createState() => _CategoryCheckState(value);
}

class _CategoryCheckState extends State<CategoryCheck> {
  bool value;
  _CategoryCheckState(bool val) {
    value = val;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(
        child: CheckboxListTile(
          activeColor: Colors.yellow[800],
          checkColor: Colors.yellow[800],
          selected: value,
          value: value,
          onChanged: (val) {
            setState(() {
              value = !value;
              (value)
                  ? categoriesList.addAll({widget.cat: widget.cName})
                  : categoriesList.remove(widget.cat);
              upDate(widget.id);
            });
          },
          title: Text(
            widget.cat,
            style: kCheckBoxTitleStyle,
          ),
          controlAffinity: ListTileControlAffinity.platform,
          secondary: Icon(kCategoryIcons[widget.cName]),
        ),
      ),
    );
  }
}

final _db = FirebaseFirestore.instance;
var user = FirebaseAuth.instance.currentUser;

Map bodies = {
  'body1': Body1(),
  'body0': Body2(),
  'body2': Body3(),
};

class Body3 extends StatelessWidget {
  const Body3({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: getApiData(
                  'https://newsapi.org/v2/top-headlines?country=$country&pageSize=50&apiKey=$key'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  Map data = jsonDecode(snapshot.data);
                  List newsList = data["articles"];
                  return Expanded(
                    child: ListView(
                      children: newsList
                          .map((e) => NewsFrame(
                                title: e['title'],
                                urlImage: e['urlToImage'],
                                date: e['publishedAt'],
                                author: e['author'],
                                content: e['content'],
                                source: e['source']['name'],
                              ))
                          .toList(),
                    ),
                  );
                } else
                  return Expanded(
                    child: Center(
                      child: LoadingBouncingGrid.square(
                        backgroundColor: Colors.yellow[800],
                      ),
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Body2 extends StatefulWidget {
  const Body2({
    Key key,
  }) : super(key: key);

  @override
  _Body2State createState() => _Body2State();
}

class _Body2State extends State<Body2> {
  String keyWord = 'latestnews', searchWord = 'latestnews';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            color: Colors.white,
            child: Center(
              child: Row(children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) {
                      setState(() => keyWord = val);
                    },
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 20),
                      contentPadding: EdgeInsets.all(10),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.yellow[800],
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() => searchWord = keyWord);
                  },
                ),
              ]),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getApiData(
                  'https://newsapi.org/v2/everything?q=$searchWord&pageSize=50&apiKey=$key'),
              builder: (contect, snapshot) {
                print(snapshot.error);
                if (snapshot.hasData) {
                  print(snapshot.data);
                  Map data = jsonDecode(snapshot.data);
                  List newsList = data["articles"];
                  return ListView(
                    children: newsList
                        .map((e) => NewsFrame(
                              title: e['title'],
                              urlImage: e['urlToImage'],
                              date: e['publishedAt'],
                              author: e['author'],
                              content: e['content'],
                              source: e['source']['name'],
                            ))
                        .toList(),
                  );
                } else
                  return LoadingBouncingGrid.square(
                    backgroundColor: Colors.yellow[800],
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Body1 extends StatefulWidget {
  const Body1({
    Key key,
  }) : super(key: key);

  @override
  _Body1State createState() => _Body1State();
}

class _Body1State extends State<Body1> {
  @override
  void initState() {
    category = 'general';
    country = 'eg';
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });
    super.initState();
  }

  String value;
  void showdialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        List<DropdownMenuItem<String>> countryList = [];
        for (var val in countryIOS2.keys) {
          countryList.add(DropdownMenuItem(
            child: Text(val),
            value: val,
            onTap: () {
              setState(() => value = val);
            },
          ));
        }
        return AlertDialog(
          backgroundColor: Colors.white,
          title: DropdownButton<String>(
            onChanged: (val) {
              Navigator.pop(context);
              showdialog(context);
            },
            hint: Text('Chose the country'),
            value: value,
            isExpanded: true,
            items: countryList,
          ),
          actions: [
            FlatButton(
              onPressed: () {
                setState(() => country = countryIOS2[value]);
                Navigator.pop(context);
              },
              child: Text(
                'Chose',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.yellow[800],
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.yellow[800],
                ),
              ),
              color: Colors.white,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.white,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.filter_list, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        showdialog(context);
                      });
                    },
                  ),
                  Hero(
                    tag: 'pro',
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'PS'),
                      child: UserAvatar(),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 5),
            color: Colors.white,
            height: 80,
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: _db.collection('Categories').snapshots(),
              builder: (context, snapshot) {
                List<Widget> categories = [];
                if (snapshot.hasData) {
                  final documents = snapshot.data.docs;
                  for (var doc in documents) {
                    if (doc.id == user.email) {
                      for (var val in doc.data().keys) {
                        categories.add(
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      category = categoriesList[val];
                                    });
                                  },
                                  child: Category(
                                    icon: kCategoryIcons[categoriesList[val]],
                                    iconcolor: Colors.white,
                                    text: val,
                                  ),
                                ),
                                Text(val),
                              ],
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
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getApiData(
                  'https://newsapi.org/v2/top-headlines?category=$category&country=$country&pageSize=50&apiKey=$key'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map data = jsonDecode(snapshot.data);
                  List newsList = data["articles"];
                  return ListView(
                    children: newsList
                        .map((e) => NewsFrame(
                              title:
                                  (e['title'] == null) ? 'Empty' : e['title'],
                              urlImage: e['urlToImage'],
                              date: (e['publishedAt'] == null)
                                  ? 'Empty'
                                  : e['publishedAt'],
                              author:
                                  (e['author'] == null) ? 'Empty' : e['author'],
                              content: (e['content'] == null)
                                  ? e['description']
                                  : e['content'],
                              source: (e['source']['name'] == null)
                                  ? 'Empty'
                                  : e['source']['name'],
                            ))
                        .toList(),
                  );
                } else
                  return LoadingBouncingGrid.square(
                    backgroundColor: Colors.yellow[800],
                  );
              },
            ),
          )
        ],
      ),
    );
  }
}

class NewsFrame extends StatefulWidget {
  NewsFrame({
    this.urlImage,
    this.title,
    this.date,
    this.author,
    this.content,
    this.source,
    this.description,
  });
  final urlImage, content, title, author, source, date, description;
  @override
  _NewsFrameState createState() => _NewsFrameState();
}

class _NewsFrameState extends State<NewsFrame> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContentScreen(
            source: (widget.source == null) ? 'Empty' : widget.source,
            content: widget.content,
            title: widget.title,
            urlImage: widget.urlImage,
            date: widget.date.substring(0, 10),
            author: widget.author,
          ),
        ),
      ),
      child: Container(
        color: Colors.grey[200],
        height: 110,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: (widget.urlImage != null)
                  ? Hero(
                      tag: widget.title,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(widget.urlImage)),
                        ),
                      ),
                    )
                  : Container(
                      child: Center(child: Text('No Image')),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white)),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '${widget.title}',
                    maxLines: 3,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text('${widget.date.substring(0, 10)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatefulWidget {
  UserAvatar({Key key}) : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  bool loading = false;
  String avatar;
  User newUser;
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    newUser = _auth.currentUser;
    getDatat();
    if (loading != true) setState(() {});
    super.initState();
  }

  getDatat() async {
    await for (var snapshot in _db.collection('Users').snapshots()) {
      for (var docs in snapshot.docs) {
        if (docs.id == newUser.email) {
          avatar = docs.data()['avatar'];
          setState(() => loading = true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Container(
            height: 35,
            width: 35,
            child: (avatar == null)
                ? Container(
                    child:
                        Center(child: Icon(Icons.person, color: Colors.white)),
                    decoration: BoxDecoration(
                        color: Colors.grey[800], shape: BoxShape.circle),
                  )
                : Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage(avatar), fit: BoxFit.contain))),
          )
        : CupertinoActivityIndicator();
  }
}

class ProfileIcon extends StatefulWidget {
  @override
  _ProfileIconState createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  bool loading = false;
  String name, email, avatar;
  User newUser;
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    newUser = _auth.currentUser;
    getDatat();
    if (loading != true) setState(() {});
    super.initState();
  }

  getDatat() async {
    await for (var snapshot in _db.collection('Users').snapshots()) {
      for (var docs in snapshot.docs) {
        if (docs.id == newUser.email) {
          name = docs.data()['name'];
          email = docs.data()['email'];
          avatar = docs.data()['avatar'];
          setState(() => loading = true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 130,
                width: 130,
                child: (avatar != null)
                    ? Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(width: 2, color: Colors.yellow[800]),
                            color: Colors.white,
                            image: DecorationImage(image: AssetImage(avatar))))
                    : Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 45,
                      ),
              ),
              SizedBox(height: 10),
              Text(name,
                  style: kYellowColorStyle.copyWith(
                      fontSize: 23, fontWeight: FontWeight.w900)),
              Text(email, style: kYellowColorStyle),
            ],
          )
        : CupertinoActivityIndicator();
  }
}

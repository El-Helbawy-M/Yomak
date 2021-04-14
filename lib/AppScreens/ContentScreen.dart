import 'package:flutter/material.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({
    this.urlImage,
    this.content,
    this.title,
    this.author,
    this.date,
    this.source,
  });
  final urlImage, content, title, author, source, date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (urlImage != null) ? Hero(
                  tag: title,
                  child: Container(
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image:  NetworkImage(urlImage)
                      ),
                    ),
                  ),
                ) : Container(height: 350,child: Center(child : Text('No Image')),decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),color: Colors.white)),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(title, style: TextStyle(fontSize: 18)),
                ),
                SizedBox(
                  height: 55,
                  child: Divider(
                    color: Colors.black,
                    thickness: .2,
                    indent: 120,
                    endIndent: 120,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    (content == null) ? 'Empty' : content,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Divider(
                    color: Colors.black,
                    thickness: .2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Author : $author',
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Source : $source',
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      SizedBox(
                        height: 40,
                        child: Divider(
                          color: Colors.black,
                          thickness: .2,
                        ),
                      ),
                      Text('Date : $date',
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      SizedBox(height : 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

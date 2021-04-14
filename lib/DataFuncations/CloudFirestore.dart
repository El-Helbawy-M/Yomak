import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:yomak/AppCompenents.dart';

final _db = FirebaseFirestore.instance;

Future addNewUserData(
        {@required String email, @required username, @required avatar}) async =>
    await _db.collection('Users').doc('$email').set({
      'email': email,
      'name': username,
      'avatar': avatar,
    });

Future addNewUsercategory({@required String id}) async {

  await _db.collection('Categories').doc('$id').set(categoriesList);
}

Future upDate(String id) async {
  await _db.collection('Categories').doc(id).set(categoriesList);
}

// 'Business': 'business',
// 'Entertainment': 'entertainment',
// 'General': 'general',
// 'Health': 'health',
// 'Science': 'science',
// 'Sports': 'sports',
// 'Technology': 'technology',

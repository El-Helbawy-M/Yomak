import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

final _auth = FirebaseAuth.instance;

Future<UserCredential> createAccount(
        {@required String email, @required password}) async =>
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

Future loginAccount({@required String email, @required password}) async =>
    await _auth.signInWithEmailAndPassword(email: email, password: password);

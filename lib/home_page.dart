import 'package:flutter/material.dart';
import 'auth_provider.dart';
import 'package:map_view/map_view.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var apiKey = "AIzaSyBlUWeW6NpkVWZ5yauucWt-RjQCE_pe6GM";
String email;
String usertype1;

String usertype;
Future<String> currentUser() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return user?.email;
}

class HomePage extends StatefulWidget {
  HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;
  void signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MapView mapView = new MapView();



  @override
  Widget build(BuildContext context) {
    foo();
    _getUtype();
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Kiwanu'),
        actions: <Widget>[
          FlatButton(
              child: Text('Logout',
                  style: TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () => widget.signOut(context))
        ],
      ),
      body: // new MarkerList(),

          Container(
        child: Center(
          child: RaisedButton(
              child: Text('CLICK ME'),
              color: Colors.red,
              textColor: Colors.white,
              elevation: 10.0,
          ),
        ),
      ),
    );
  }
}

foo() async {
  email = await currentUser();
}

_getUtype() async {
  Firestore.instance
      .collection('users')
      .where('email', isEqualTo: '$email')
      .snapshots()
      .listen((data) {
    usertype = data.documents[0]['usertype'];
  });
}

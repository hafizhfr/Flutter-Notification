import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

enum Options { YES, NO }

class _State extends State<MyApp> {
  String _value = '';

  void _setValue(String value) => setState(() => _value = value);

  Future _askUser() async {
    switch (await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text('Simple Dialog Message'),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text('YES'),
              onPressed: () {
                Navigator.pop(context, Options.YES);
              },
            ),
            new SimpleDialogOption(
              child: new Text('NO'),
              onPressed: () {
                Navigator.pop(context, Options.NO);
              },
            )
          ],
        ))) {
      case Options.YES:
        _setValue('YES');
        break;
      case Options.NO:
        _setValue('NO');
        break;
    }
  }

  void _showBottom() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            padding: new EdgeInsets.all(2.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'Bottom Sheet Info',
                  style: new TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                new RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  child: new Text('Close'),
                ),
              ],
            ),
          );
        });
  }

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  void _showBar(String message) {
    //show snack bar
    _scaffoldState.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  Future _showAlert(BuildContext context, String message) async {
    return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: new Text('OK'))
          ],
        ));
  }

  void _onChanged(String value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldState,
      appBar: new AppBar(
        title: new Text('App Bar Title'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new RaisedButton(
                  onPressed: _showBottom,
                  child: new Text('Show Bottom Sheet'),
                ),
                new RaisedButton(
                  onPressed: () => _showBar('Snack Bar Message'),
                  child: new Text('Show Snack Bar'),
                ),
                new RaisedButton(
                  onPressed: () => _showAlert(context, 'Alert Dialog Message'),
                  child: new Text('Show Alert Dialog'),
                ),
                new RaisedButton(
                  onPressed: _askUser,
                  child: new Text('Show Simple Dialog'),
                ),

                new TextField(
                  onChanged: _onChanged,
                  decoration: InputDecoration(
                      hintText: 'Enter your name',
                      suffixIcon:
                          IconButton(onPressed: () => _showBar(_value), icon: Icon(Icons.add),)),
                ),
                new Text('Value is $_value', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
              ],
            ),
          )),
    );
  }
}

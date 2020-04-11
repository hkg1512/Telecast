//System Packages
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class FullReadScreen extends StatefulWidget{
  final String _newsURL;
  FullReadScreen(this._newsURL);

@override
  _FullReadScreenState createState() => _FullReadScreenState(this._newsURL);
}

class _FullReadScreenState extends State<FullReadScreen>{
  final String _newsURL;
  _FullReadScreenState(this._newsURL);

  @override
  Widget build(BuildContext context) {
    print(this._newsURL);
    return Scaffold(
      body:WebviewScaffold(
        url: this._newsURL,
        appBar: new AppBar(title: new Text("")),)
    );
  }
}
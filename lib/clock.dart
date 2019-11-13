import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SimpleClock extends StatefulWidget {
  final String url;
  final String text;

  SimpleClock(this.text, this.url);

  @override
  State<StatefulWidget> createState() => _SimpleClockState(text, url);
}

class _SimpleClockState extends State<SimpleClock> {
  Future<int> _futureResult;
  final String url;
  final String title;

  _SimpleClockState(this.title, this.url);

  @override
  void initState() {
    super.initState();
    _futureResult = fetch();
    Timer.periodic(Duration(seconds: 15), (Timer t) {
      if (!mounted) return;
      setState(() {
        _futureResult = fetch();
      });
    });
  }

  Future<int> fetch() async {
    final res = await http.get(url);
    return int.parse(res.body);
  }

  Text createText(String text) => Text(text,
      textDirection: TextDirection.ltr,
      style: TextStyle(
        fontSize: 30,
        fontFamily: "Helvetica",
        fontWeight: FontWeight.w300,
      ));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            createText(title),
            FutureBuilder<int>(
              future: _futureResult,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return createText(snapshot.data.toString());
                } else if (snapshot.hasError) {
                  return createText("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}

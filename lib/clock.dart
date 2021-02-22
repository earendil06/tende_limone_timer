import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SimpleClock extends StatefulWidget {
  final String url;
  final String fromImage;
  final String toImage;
  final String fromText;
  final String toText;

  SimpleClock(
      this.url, this.fromImage, this.toImage, this.fromText, this.toText);

  @override
  State<StatefulWidget> createState() =>
      _SimpleClockState(url, fromImage, toImage, fromText, toText);
}

class _SimpleClockState extends State<SimpleClock> {
  Future<int> _futureResult;
  final String url;
  final String fromImage;
  final String toImage;
  final String fromText;
  final String toText;

  _SimpleClockState(
      this.url, this.fromImage, this.toImage, this.fromText, this.toText);

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
        fontSize: 24,
        fontFamily: "Helvetica",
        fontWeight: FontWeight.w300,
      ));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset(fromImage,
                        width: MediaQuery.of(context).size.width / 4),
                    decoration: BoxDecoration(border: Border.all()),
                  ),

                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(fromText,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w300,
                          )))
                ],
              )),
              Icon(Icons.arrow_right, color: Colors.black, size: 48.0),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset(toImage,
                        width: MediaQuery.of(context).size.width / 4),
                    decoration: BoxDecoration(border: Border.all()),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(toText,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w300,
                          )))
                ],
              ))
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: FutureBuilder<int>(
                future: _futureResult,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return createText(snapshot.data.toString() + " min");
                  } else if (snapshot.hasError) {
                    return createText("- min");
                  }
                  return CircularProgressIndicator();
                },
              ))
        ],
      ),
    );
  }
}

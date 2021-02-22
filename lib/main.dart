import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'clock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: "ca-app-pub-8141904202528647~9452198431");
  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: "ca-app-pub-8141904202528647/2990376645",
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  myInterstitial
    ..load()
    ..show(
      anchorType: AnchorType.bottom,
      anchorOffset: 0.0,
      horizontalCenterOffset: 0.0,
    );

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'Tende Limone Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Column(
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.error_outline, color: Colors.orange),
                    contentPadding: const EdgeInsets.all(15.0),
                    title: Text('Weather conditions'),
                    subtitle: Text(
                        'The remaning time computation is based on image analysis. Please understand that the values could be wrong in case of bad weather conditions.'),
                  )
                ],
              ),
            ),
            Card(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SimpleClock(
                        'https://tunnel-server.florentpastor.com/italy',
                        'assets/images/italy.png',
                        'assets/images/france.png',
                        "ITA",
                        "FRA")),
              ],
            )),
            Card(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SimpleClock(
                        'https://tunnel-server.florentpastor.com/france',
                        'assets/images/france.png',
                        'assets/images/italy.png',
                        "FRA",
                        "ITA")),
              ],
            )),
//            Card(
//              child: Column(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.all(20.0),
//                    child: Image.network(
//                      'https://picsum.photos/250?image=9',
//                    ),
//                  )
//                ],
//              ),
//            )
          ],
        ))
    )
    );
  }
}

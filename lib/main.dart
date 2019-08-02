import 'app.dart';
import 'package:flutter/material.dart';

import 'package:firebase_admob/firebase_admob.dart';
import 'ads.dart';

//import all screens
import 'screens/Home.dart';
import 'screens/About.dart';
import 'screens/Contact.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: getAppId());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(primaryColor: maincolor),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/about': (context) => AboutScreen(),
        '/contact': (context) => ContactScreen(),
      },
      // builder: (BuildContext context, Widget child) {
      //   myBanner
      //     ..load()
      //     ..show(
      //       anchorOffset: 0.0,
      //       anchorType: AnchorType.bottom,
      //     );

      // myBanner..isLoaded().then((onValue){
      //   print("loaded" + onValue.toString());
      // });
        
      //   print('randomBanner' + randomBanners());
      //   print('randomInterval' + randomIntervals());

      //   return Padding(
      //       child: child, padding: const EdgeInsets.only(bottom: 70.0));
      // },
    );
  }
}

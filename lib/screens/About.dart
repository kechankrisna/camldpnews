import '../app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onloadUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(builder: (BuildContext context, Widget child) {
      return Padding(
          padding: EdgeInsets.only(bottom: 60),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: maincolor,
              centerTitle: true,
              title: Center(
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      logo,
                      width: 45.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(short_appname),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.local_activity),
                  onPressed: () {
                    _onloadUrl("$contact_url");
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _onloadUrl("$contact_email");
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.call),
                  onPressed: () {
                    _onloadUrl("tel:$contact_phone");
                  },
                )
              ],
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  width: 250.0,
                  padding: EdgeInsets.all(50),
                  child: Image.asset(
                    logo,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: maincolor,
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    slogan,
                    style: TextStyle(color: secondcolor, fontSize: 20),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    description,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, wordSpacing: 10.0),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}

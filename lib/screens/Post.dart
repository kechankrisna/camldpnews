import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_properties.dart';

import '../app.dart';
import 'package:flutter/material.dart';
import '../models/Post.dart';

import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class PostScreen extends StatefulWidget {
  final Post post;

  const PostScreen({Key key, this.post}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
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
    final _width = MediaQuery.of(context).size.width;

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
            body: Container(
              width: _width,
              padding: EdgeInsets.all(0),
              child: ListView(
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: placeholder,
                    image: this.widget.post.image,
                  ),
                  // Image.asset(postAds),

                  Card(
                    child: ListTile(
                      dense: true,
                      leading: Image.asset(logo),
                      title: Text(title),
                      subtitle: Text(slogan),
                      trailing: RaisedButton(
                        onPressed: () => _onloadUrl(contact_youtube),
                        color: Colors.red,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            Text(
                              "SUBSCRIBE",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    child: Text(
                      this.widget.post.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF00469A),
                        backgroundColor: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SingleChildScrollView(
                      padding: EdgeInsets.all(3.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Html(
                          defaultTextStyle: TextStyle(fontSize: 16),
                          imageProperties: ImageProperties(
                              fit: BoxFit.fitWidth,
                              matchTextDirection: true,
                              height: _width * 0.8),
                          data: this.widget.post.content.toString(),
                          //Optional parameters:
                          padding: EdgeInsets.all(5.0),
                          linkStyle: const TextStyle(
                            color: Colors.blueAccent,
                            decorationColor: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),

                          onLinkTap: (url) {
                            _onloadUrl("$url");
                          },
                          customRender: (node, children) {
                            if (node is dom.Element) {
                              switch (node.localName) {
                                case "custom_tag":
                                  return Column(children: children);
                              }
                            }
                          },
                        ),
                      )),

                  Card(
                    child: ListTile(
                      dense: true,
                      leading: Image.asset(this.widget.post.authorAvatar == null
                          ? logo
                          : this.widget.post.authorAvatar),
                      title: Text(this.widget.post.authorName),
                      subtitle: Text(this.widget.post.authorDescription),
                      trailing: RaisedButton(
                        onPressed: () {
                          final RenderBox box = context.findRenderObject();
                          Share.share(this.widget.post.link,
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size);
                        },
                        color: maincolor,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.screen_share,
                              color: Colors.white,
                            ),
                            Text(
                              "ចែករំលែក",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}

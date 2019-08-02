import 'package:firebase_admob/firebase_admob.dart';

import '../app.dart';
import '../ads.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/Post.dart'; //post model
import '../widgets/drawer.dart'; //drawer widget
import '../widgets/Postlist.dart';
import '../widgets/Postcard.dart';
import '../widgets/Search.dart';
import 'Post.dart'; //post screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> posts, trends;
  int page = 1;
  bool firstLoad = true;
  bool isLoading = false;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    _fetchPosts();
  }

  //scroll controller
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent - 20 &&
        !_controller.position.outOfRange) {
      setState(() {
        _fetchPosts();
        // message = "reach the bottom";
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the top";
      });
    }
  }

  Future<Null> _fetchPosts() async {
    List<Post> newposts = [];
    setState(() {
      isLoading = true;
    });

    final respone = await http.get(apiUrl + post + '&page=' + page.toString());
    if (respone.statusCode == 200) {
      final jsonData = json.decode(respone.body);
      for (var p in jsonData) {
        var post = Post(
          id: p['id'],
          date: p['date'],
          title: p['title']['rendered'],
          excerpt: p['excerpt']['rendered'],
          content: p['content']['rendered'],
          thumbnail: p["_embedded"]["wp:featuredmedia"][0] == null ||
                  p["_embedded"]["wp:featuredmedia"][0]['media_details'] ==
                      null ||
                  p["_embedded"]["wp:featuredmedia"][0]['media_details']
                          ['sizes'] ==
                      null
              ? placeholder
              : p["_embedded"]["wp:featuredmedia"][0]['media_details']['sizes']
                  ['thumbnail']["source_url"],
          image: p["_embedded"]["wp:featuredmedia"][0] == null ||
                  p["_embedded"]["wp:featuredmedia"][0]['media_details'] ==
                      null ||
                  p["_embedded"]["wp:featuredmedia"][0]['media_details']
                          ['sizes'] ==
                      null
              ? placeholder
              : p["_embedded"]["wp:featuredmedia"][0]['media_details']['sizes']
                  ['medium_large']["source_url"],
          categories: p['categories'],
          link: p['link'],
          type: p['type'],
          authorName: p["_embedded"]["author"][0]["name"],
          authorDescription: p["_embedded"]['author'][0]['description'],
          authorAvatar: p["_embedded"]['author'][0]['avatar_urls'][0],
          authorUrl: p["_embedded"]['author'][0]['url'],
        );

        newposts.add(post);
      }

      if (firstLoad) {
        trends = posts = newposts;
        setState(() {
          firstLoad = false;
          isLoading = false;
          page++;
        });
      } else if (isLoading) {
        posts = List.from(posts)..addAll(newposts);
        setState(() {
          isLoading = false;
          page++;
        });
      }
    } else {
      throw Exception("Fail to load:");
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: MaterialApp(
          builder: (BuildContext context, Widget child) {
            myBanner
              ..load()
              ..show(
                anchorOffset: 0.0,
                anchorType: AnchorType.bottom,
              );

            myBanner
              ..isLoaded().then((onValue) {
                print("loaded" + onValue.toString());
              });

            print('randomBanner' + randomBanners());
            print('randomInterval' + randomIntervals());
            return Padding(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: maincolor,
                  centerTitle: true,
                  titleSpacing: 0.0,
                  title: Center(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Image.asset(
                          logo,
                          width: 45.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(title),
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    isLoading
                        ? SpinKitFadingCircle(
                            size: 45,
                            itemBuilder: (_, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color:
                                      index.isEven ? Colors.white : Colors.blue,
                                ),
                              );
                            },
                          )
                        : IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchWidget(
                                        s: '',
                                      ),
                                ),
                              );
                            },
                            icon: Icon(Icons.search),
                          )
                  ],
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.trending_up),
                        text: "ពត័មានថ្មីៗ",
                      ),
                      Tab(
                        icon: Icon(Icons.developer_board),
                        text: "ពត័មានទូទៅ",
                      ),
                    ],
                  ),
                ),
                drawer: CustomDrawer(),
                body: TabBarView(
                  children: <Widget>[
                    firstLoad
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: trends.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                child: PostList(
                                  post: this.trends[index],
                                ),
                                onTap: () {
                                  myInterstitial
                                    ..load()
                                    ..show();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PostScreen(post: trends[index]),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                    firstLoad
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: posts.length,
                            controller: _controller,
                            itemBuilder: (BuildContext context, int index) {
                              return PostCard(
                                post: this.posts[index],
                                onRead: () {
                                  myInterstitial
                                    ..load()
                                    ..show();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PostScreen(post: posts[index]),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                  ],
                ),
              ),
              padding: EdgeInsets.only(bottom: 60),
            );
          },
        ));
  }
}

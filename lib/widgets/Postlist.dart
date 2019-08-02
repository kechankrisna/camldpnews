import 'package:camldpnews/app.dart';
import 'package:flutter/material.dart';
import '../models/Post.dart';

class PostList extends StatelessWidget {
  final Post post;

  const PostList({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(this.post.title),
            ),
          ),
          Expanded(
            flex: 4,
            child: this.post.thumbnail == placeholder ? Image.asset(this.post.thumbnail) : Image.network(this.post.thumbnail),
          )
        ],
      ),
    );
  }
}

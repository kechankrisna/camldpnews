import '../app.dart';
import 'package:flutter/material.dart';
import '../models/Post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onRead;

  const PostCard({Key key, this.post, this.onRead}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          this.post.image == placeholder ? Image.asset(this.post.image) : Image.network(this.post.image),
          ListTile(
            title: Text(this.post.title),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FlatButton(
                onPressed: () => print("like"),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.thumb_up,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "ពេញចិត្ត",
                      ),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => print("comment"),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "បញ្ចេញមតិ",
                      ),
                    )
                  ],
                ),
              ),
              FlatButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.remove_red_eye),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text('ចុចអាន'),
                    )
                  ],
                ),
                onPressed: onRead,
                
                // onPressed: () {
                //   print("object");
                //   // myInterstitial
                //   //   ..load()
                //   //   ..show(
                //   //       anchorOffset: 0.0,
                //   //       anchorType: AnchorType.bottom);
                //   // Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute(
                //   //     builder: (context) =>
                //   //         PostScreen(post: posts[index]),
                //   //   ),
                //   // );
                // },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

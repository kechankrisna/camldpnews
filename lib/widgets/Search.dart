import 'package:camldpnews/screens/Search.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String s;

  const SearchWidget({Key key, this.s}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String s;

  @override
  void initState() {
    super.initState();
    setState(() {
      s = this.widget.s;
    });
  }

  TextEditingController _textEditingController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 1.0,
          automaticallyImplyLeading: false,
          title: Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: TextField(
              // initialValue: this.widget.s.toString(),
              autofocus: true,
              cursorColor: Colors.white,

              onChanged: (word) {
                // print(s.toString());
                setState(() {
                  this.s = word;
                });
              },
              onSubmitted: (String s) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(s: this.s.toString()),
                  ),
                );
              },
              textInputAction: TextInputAction.search,
              controller: _textEditingController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                suffixIcon: s.toString().isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchScreen(s: this.s.toString()),
                            ),
                          );
                        },
                        icon: Icon(Icons.search),
                      )
                    : IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.cancel),
                      ),
                filled: true,
                hasFloatingPlaceholder: true,
                labelText: this.s.isEmpty ? "ស្វែងរក...." : "",
              ),
            ),
          )),
      body: Container(
        color: Colors.black87,
      ),
    );
  }
}

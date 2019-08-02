import 'package:flutter/material.dart';
import '../models/Category.dart';
import './../screens/Category.dart';
import '../app.dart';

class CustomDrawer extends StatefulWidget {
  //static list of category

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<Category> _categories = [
    Category(
      id: 6,
      title: "នយោបាយ",
      icon: Icon(
        Icons.speaker_group,
        color: Colors.white,
      ),
    ),
    Category(
      id: 13,
      title: "មេរៀនជីវិត",
      icon: Icon(
        Icons.person,
        color: Colors.white,
      ),
    ),
    Category(
      id: 4,
      title: "ពត័មានគណបក្ស",
      icon: Icon(
        Icons.info,
        color: Colors.white,
      ),
    ),
    Category(
      id: 2,
      title: "ពត័មានជាតិ",
      icon: Icon(
        Icons.new_releases,
        color: Colors.white,
      ),
    ),
    Category(
      id: 3,
      title: "ពត័មានអន្តរជាតិ",
      icon: Icon(
        Icons.map,
        color: Colors.white,
      ),
    ),
    Category(
      id: 5,
      title: "កំរងទស្សនៈ",
      icon: Icon(
        Icons.edit,
        color: Colors.white,
      ),
    ),
    Category(
      id: 1,
      title: "ផ្សេងៗ",
      icon: Icon(
        Icons.more,
        color: Colors.white,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            color: maincolor, //rgba(26, 35, 126,1.0)
            child: ListView.builder(
              itemCount: this._categories.length.toInt() + 2,
              itemBuilder: (BuildContext context, int index) {
                return index == 0
                    ? Column(
                        children: <Widget>[
                          UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                                color: maincolor,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.white))),
                            otherAccountsPictures: <Widget>[
                              GestureDetector(
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                                onTap: null,
                              )
                            ],
                            currentAccountPicture: CircleAvatar(
                              backgroundImage: AssetImage(logo),
                            ),
                            accountName: Text(title),
                            accountEmail: Text(slogan),
                          ),
                          ListTile(
                            onTap: () => Navigator.of(context).pushNamed('/'),
                            leading: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            title: Text(
                              "ទំព័រដើម",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )
                    : index > this._categories.length
                        ? Column(
                            children: <Widget>[
                              Divider(
                                indent: 1.0,
                                color: Colors.white,
                              ),
                              ListTile(
                                onTap: () =>
                                    Navigator.of(context).pushNamed('/about'),
                                leading: Icon(
                                  Icons.assignment_ind,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  "អំពីយើងខ្ញុំ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ListTile(
                                onTap: () =>
                                    Navigator.of(context).pushNamed('/contact'),
                                leading: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  "ទំនាក់ទំនងមកកាន់យើងខ្ញុំ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        : ListTile(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryScreen(
                                        id: this
                                            ._categories[index - 1]
                                            .id
                                            .toInt(),
                                        title: this
                                            ._categories[index - 1]
                                            .title
                                            .toString()),
                                  ),
                                ),
                            leading: this._categories[index - 1].icon,
                            title: Text(
                              this._categories[index - 1].title.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          );
              },
            )));
  }
}

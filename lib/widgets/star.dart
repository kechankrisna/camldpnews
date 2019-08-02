import 'package:flutter/material.dart';

//star rate widgets

class StarsWidget extends StatelessWidget {
  final int star;

  const StarsWidget({Key key, this.star}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.star,
            size: 12,
            color: this.star >= 1 ? Colors.orange : Colors.grey,
          ),
          Icon(
            Icons.star,
            size: 12,
            color: this.star >= 2 ? Colors.orange : Colors.grey,
          ),
          Icon(
            Icons.star,
            size: 12,
            color: this.star >= 3 ? Colors.orange : Colors.grey,
          ),
          Icon(
            Icons.star,
            size: 12,
            color: this.star >= 4 ? Colors.orange : Colors.grey,
          ),
          Icon(
            Icons.star,
            size: 12,
            color: this.star >= 5 ? Colors.orange : Colors.grey,
          )
        ],
      ),
    );
  }
}

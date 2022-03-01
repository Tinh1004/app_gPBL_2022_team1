import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  var time;
  var value;
  var check;
  Todo(this.time, this.value, this.check);

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.time,
            style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
                color: Colors.black38
            ),
          ),
          Text(
            widget.value,
            style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
                color: widget.check == 1 ? Colors.blueAccent
                    : double.parse(widget.value) >30
                      ? Colors.orangeAccent
                      : double.parse(widget.value) < 25
                        ? Colors.blueAccent
                        : Colors.greenAccent
              ),
          )
        ],
      ),
    );
  }
}

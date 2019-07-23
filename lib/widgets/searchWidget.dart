import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchWidget extends AnimatedWidget {
  AnimationController controller;
  bool _expanded = false;
  TextEditingController filter;

  SearchWidget({Key key, Animation<double> expandAnimation, this.controller, this.filter})
      : super(key: key, listenable: expandAnimation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
          child: Row(
            children: <Widget>[
              Container(
                  height: 50,
                  width: animation.value,
                  margin: const EdgeInsets.only(right: 20, top: 10),
                  child: TextField(
                    controller: filter,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter search text here'),
                  )),
              IconButton(
                icon: _expanded?Icon(Icons.clear):Icon(Icons.search),
                onPressed: () {
                  if(_expanded) {
                    _expanded = false;
                    controller.reverse();
                  } else {
                    _expanded = true;
                    controller.forward();
                  }
                },
              ),
            ],
          )),
    );
  }
}

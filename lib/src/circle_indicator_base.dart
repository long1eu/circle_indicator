// Copyright (c) 2017, long1eu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:flutter/material.dart';

class CircleIndicator extends StatefulWidget {
  ///The page controller attached to the PageViewer.
  final PageController pagerController;

  ///The numbers of pages the PageViewer contains.
  final int size;

  ///The radius of the selected dot.
  final double radius;

  ///The color of the unselected dots.
  final Color baseColor;

  ///The color of the selected dots.
  final Color selectedColor;

  CircleIndicator(this.pagerController, this.size, this.radius, this.baseColor,
      this.selectedColor);

  CircleIndicator.withIntroduction(this.size, this.radius, this.baseColor,
      this.selectedColor, {this.pagerController: null});

  @override
  State<StatefulWidget> createState() =>
      new _CircleIndicatorState(
          pagerController, size, radius, baseColor, selectedColor);

  static CircleIndicator get(CircleIndicator indicator,
      PageController pagerController) {
    return new CircleIndicator(
        pagerController, indicator.size, indicator.radius, indicator.baseColor,
        indicator.selectedColor);
  }
}

class _CircleIndicatorState extends State<CircleIndicator>
    with TickerProviderStateMixin {
  final PageController pagerController;
  final int size;
  final double radius;
  final Color baseColor;
  final Color selectedColor;

  int oldPage = 0;
  int page = 0;

  double oldOffset = 0.0;

  Row items;

  _CircleIndicatorState(this.pagerController, this.size, this.radius,
      this.baseColor, this.selectedColor) {
    pagerController.addListener(animate);
    List<Container> icons = new List();
    for (int i = 0; i < size; i++) {
      icons.add(new Container(
        margin: new EdgeInsets.all(4.0),
        child: new _AnimatedCircleAvatar(
          controller: new AnimationController(
            duration: new Duration(milliseconds: 100),
            vsync: this,
          ),
          color: Colors.white,
          radius: radius,
        ),
      ));
    }

    items = new Row(
      children: icons,
    );
    getController(items.children.elementAt(0)).forward();
  }


  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      alignment: FractionalOffset.bottomCenter,
      child: items,
    );
  }

  void animate() {
    bool isInLimits = pagerController.position.minScrollExtent <=
        pagerController.offset &&
        pagerController.offset <= pagerController.position.maxScrollExtent;

    page = pagerController.offset ~/
        pagerController.position.viewportDimension;

    if (!isInLimits) return;
    bool directionNormal = oldOffset - pagerController.offset <= 0;

    var oldController = getController(items.children.elementAt(oldPage));
    var controller = getController(items.children.elementAt(page));
    var nextController;
    if (page + 1 < size) {
      nextController = getController(items.children.elementAt(page + 1));
    }

    if (directionNormal) {
      oldController.reverse();
      controller.forward();
    } else {
      controller.forward();
      nextController?.reverse();
    }


    oldPage = page;
    oldOffset = pagerController.offset;
  }

  AnimationController getController(Widget widget) {
    if (widget is Container) {
      var i = widget.child;
      if (i is _AnimatedCircleAvatar) {
        return i.controller;
      }
    }
    return null;
  }
}


class _AnimatedCircleAvatar extends Container {

  final AnimationController controller;
  final double radius;

  _AnimatedCircleAvatar({this.controller, this.radius, color})
      : super(
    decoration: new BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    width: radius * 2,
    height: radius * 2,
  );

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        new ScaleTransition(
          scale: new CurvedAnimation(
              parent: controller,
              curve: Curves.linear,
              reverseCurve: Curves.bounceOut
          ),
          child: super.build(context),
        ),
        new Container(
          width: radius,
          height: radius,
          decoration: new BoxDecoration(
            color: Colors.white70,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
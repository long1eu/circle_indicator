// Copyright (c) 2017, long1eu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:circle_indicator/circle_indicator.dart';
import 'package:flutter/material.dart';

class IntroductionWidget extends StatefulWidget {

  final List<Widget> pageList;
  final Color backgroundColor;
  final CircleIndicator circleIndicator;
  final Function onComplete;
  final Text onCompleteText;

  IntroductionWidget({this.pageList, this.backgroundColor, this.circleIndicator,
    this.onComplete, this.onCompleteText});

  @override
  State<StatefulWidget> createState() =>
      new _IntroductionWidgetState(pageList, backgroundColor, circleIndicator,
          onComplete, onCompleteText);

}

class _IntroductionWidgetState extends State<IntroductionWidget> {

  final List<Widget> pageList;
  final Color backgroundColor;
  final CircleIndicator circleIndicator;
  final Function onComplete;
  final Text onCompleteText;

  final PageController controller = new PageController();

  bool showStart = false;
  int previousPage = 0;

  _IntroductionWidgetState(this.pageList, this.backgroundColor,
      this.circleIndicator, this.onComplete, this.onCompleteText);

  @override
  Widget build(BuildContext context) {
    Container rootWidget = createPages();
    controller.addListener(pagerListener);

    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.only(top: 32.0,),
        decoration: new BoxDecoration(
          color: backgroundColor,
        ),
        child: rootWidget,
      ),
    );
  }

  Container createPages() {
    var childrenList = <Widget>[
      new PageView.builder(
        controller: controller,
        itemCount: pageList.length,
        itemBuilder: (_, int i) => pageList[i],
      ),
      new Container(
        margin: new EdgeInsets.symmetric(vertical: 16.0),
        child: CircleIndicator.get(circleIndicator, controller),
      ),
    ];

    if (showStart) {
      childrenList.add(
        new Container(
          alignment: FractionalOffset.bottomRight,
          margin: new EdgeInsets.all(16.0),
          child: new GestureDetector(
            onTap: onComplete,
            child: onCompleteText,
          ),
        ),
      );
    }

    return new Container(
      child: new Stack(
        alignment: FractionalOffset.bottomCenter,
        children: childrenList,
      ),
    );
  }

  void pagerListener() {
    setState(() => showStart = controller.page == pageList.length - 1);
  }
}
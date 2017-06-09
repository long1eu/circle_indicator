// Copyright (c) 2017, long1eu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:circle_indicator/circle_indicator.dart';
import 'package:flutter/material.dart';

typedef bool ShouldShow(int pageNumber);

class IntroductionWidget extends StatefulWidget {

  final List<Widget> pageList;
  final Color backgroundColor;
  final CircleIndicator circleIndicator;

  final Function rightAction;
  final Text rightText;
  final ShouldShow showRight;
  final Function leftAction;
  final Text leftText;
  final ShouldShow showLeft;

  IntroductionWidget({this.pageList, this.backgroundColor, this.circleIndicator,
    this.rightAction, this.rightText, this.showRight, this.leftAction,
    this.leftText, this.showLeft}) {
    assert((rightAction != null && rightText != null)
        ||
        (rightAction == null && rightText == null));

    assert((leftAction != null && leftText != null)
        ||
        (leftAction == null && leftText == null));
  }


  @override
  State<StatefulWidget> createState() =>
      new _IntroductionWidgetState(
          pageList,
          backgroundColor,
          circleIndicator,
          rightAction,
          rightText,
          showRight,
          leftAction,
          leftText,
          showLeft);

}

class _IntroductionWidgetState extends State<IntroductionWidget> {

  final List<Widget> pageList;
  final Color backgroundColor;
  final CircleIndicator circleIndicator;
  final Function rightAction;
  final Text rightText;
  ShouldShow showRightValidation;
  final Function leftAction;
  final Text leftText;
  ShouldShow showLeftValidation;

  final PageController controller = new PageController();

  bool showLeft = false;
  bool showRight = false;

  int previousPage = 0;

  _IntroductionWidgetState(this.pageList, this.backgroundColor,
      this.circleIndicator, this.rightAction, this.rightText,
      this.showRightValidation, this.leftAction,
      this.leftText, this.showLeftValidation) {

    ///If you don't pass any validation the left action is always visible
    if (showLeftValidation == null) showLeftValidation = (_) => true;

    ///If you don't pass any validation to the right, the action is displayed only
    ///on the last page
    if (showRightValidation == null)
      showRightValidation = (page) => page == pageList.length - 1;

    showLeft = showLeftValidation(0);
    showRight = showRightValidation(0);
  }

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

    if (showRight) {
      childrenList.add(
        new Container(
          alignment: FractionalOffset.bottomRight,
          margin: new EdgeInsets.all(16.0),
          child: new GestureDetector(
            onTap: rightAction,
            child: rightText,
          ),
        ),
      );
    }

    if (showLeft) {
      childrenList.add(
        new Container(
          alignment: FractionalOffset.bottomLeft,
          margin: new EdgeInsets.all(16.0),
          child: new GestureDetector(
            onTap: leftAction,
            child: leftText,
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
    setState(() {
      int page = controller.page.toInt();
      showRight = showRightValidation(page);
      showLeft = showLeftValidation(page);
    });
  }
}
# circle_indicator

A library for Dart developers. It is awesome.

![Demo:](/indicator.gif)

## Installation




## Usage

A simple usage example:
    
    final PageController controller = new PageController();
    
    @override
      Widget build(BuildContext context) {
        return new Scaffold(
          body: new Container(
              padding: new EdgeInsets.only(top: 16.0,),
              decoration: new BoxDecoration(
                  color: primaryColor
              ),
              child: new Stack(
                alignment: FractionalOffset.bottomCenter,
                children: <Widget>[
                  new PageView.builder(
                    controller: controller,
                    itemCount: pageList.length,
                    itemBuilder: (_, int i) => pageList[i],
                  ),
                  new Container(
                    margin: new EdgeInsets.only(
                      top: 16.0,
                      bottom: 16.0,
                    ),
                    child: new CircleIndicator(controller, 3.0, Colors.white70, Colors.white)
                    ),
                  ),
                ],
              )
          ),
        );
      }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/thelong1EU/circle_indicator/issues

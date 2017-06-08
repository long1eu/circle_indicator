# circle_indicator

A library for Dart developers. It is awesome.

![Demo:](/indicator.gif)

## Installation

1. Depend on it
Add this to your package's pubspec.yaml file:

       dependencies:
         circle_indicator: "^0.0.1"
2. Install it
You can install packages from the command line:

       $ pub get
Alternatively, your editor might support 'pub get'. Check the docs for your editor to learn more.

3. Import it
Now in your Dart code, you can use:

       import 'package:circle_indicator/circle_indicator.dart';



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

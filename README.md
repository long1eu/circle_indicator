# circle_indicator

A library for Dart developers. It is awesome.

![Demo:](https://raw.githubusercontent.com/thelong1EU/circle_indicator/master/indicator.gif)

## Installation

1. Depend on it
Add this to your package's pubspec.yaml file:

       dependencies:
         circle_indicator: "^0.0.6"
         
2. Install it
You can install packages from the command line:

       $ pub get
       
Alternatively, your editor might support 'pub get'. Check the docs for your editor to learn more.

3. Import it
Now in your Dart code, you can use:

       import 'package:circle_indicator/circle_indicator.dart';




## Usage

A simple usage example for the CircleIndicator:
    
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
                    child: new CircleIndicator(controller, pageList.length, 
                      3.0, Colors.white70, Colors.white)
                    ),
                  ),
                ],
              )
          ),
        );
      }
      
If you want to use the whole IntroductionWidget you can do it like so:

    class StartPage extends StatelessWidget {
    
      @override
      Widget build(BuildContext context) {
        var pageList = <StartPageItem>[
          new StartPageItem("assets/ic_info_01.png"),
          new StartPageItem("assets/ic_info_02.png"),
          new StartPageItem("assets/ic_info_03.png"),
          new StartPageItem("assets/ic_info_04.png"),
          new StartPageItem("assets/ic_info_05.png"),
          new StartPageItem("assets/ic_info_06.png"),
          new StartPageItem("assets/ic_info_07.png"),
          new StartPageItem("assets/ic_info_08.png"),
        ];
    
        return new Scaffold(
          body: new IntroductionWidget(
            pageList: pageList,
            circleIndicator: new CircleIndicator.withIntroduction(
                pageList.length, 3.0, Colors.white70, Colors.white),
            onComplete: () => startApp(context),
            onCompleteText: new Text("START",
              style: Theme
                  .of(context)
                  .textTheme
                  .body1
                  .copyWith(
                color: Colors.white,),
            ),
            backgroundColor: primaryColor,
          ),
        );
      }
    
    
      void startApp(BuildContext context) {
        Navigator.popAndPushNamed(context, HomePage.routeName);
      }
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/thelong1EU/circle_indicator/issues

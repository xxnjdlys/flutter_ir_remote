import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_ir_remote/AppColors.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  return runApp(UniversalControllerApp());
}

class UniversalControllerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IR Remote Control',
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BehaviorSubject<int> willAcceptStream;

  Color background = AppColors.lightBackground;
  Color text = AppColors.lightText;
  Color select = AppColors.lightSelect;
  Color icon = AppColors.lightIcon;
  Color buttonBackground = AppColors.lightButtonBackground;
  Color iconButton = AppColors.lightIconButton;

  @override
  void initState() {
    willAcceptStream = new BehaviorSubject<int>();
    willAcceptStream.add(0);
    super.initState();
  }

  void _fuctionDrag(String msg) {
    final snackBar = SnackBar(
        content: Text('$msg'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 500));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        color: background,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: 'IR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: text,
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Remote',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: text,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.personal_video,
                          color: select,
                          size: 28,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: select,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.11,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: size.height * 0.11,
                        height: size.height * 0.08,
                        child: Icon(
                          Icons.volume_down,
                          color: icon,
                          size: 28,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(
                            () {
                              background =
                                  background == AppColors.darkBackground
                                      ? AppColors.lightBackground
                                      : AppColors.darkBackground;
                              text = text == AppColors.darkext
                                  ? AppColors.lightText
                                  : AppColors.darkext;
                              select = select == AppColors.darkSelect
                                  ? AppColors.lightSelect
                                  : AppColors.darkSelect;
                              icon = icon == AppColors.darkIcon
                                  ? AppColors.lightIcon
                                  : AppColors.darkIcon;
                              iconButton =
                                  iconButton == AppColors.darkIconButton
                                      ? AppColors.lightIconButton
                                      : AppColors.darkIconButton;
                              buttonBackground = buttonBackground ==
                                      AppColors.darkButtonBackground
                                  ? AppColors.lightButtonBackground
                                  : AppColors.darkButtonBackground;
                            },
                          );
                          print("Power Pressed");
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          width: size.height * 0.11,
                          height: size.height * 0.11,
                          decoration: new BoxDecoration(
                            color: buttonBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.power_settings_new,
                            color: Color(0xFFEF5252),
                            size: 38,
                          ),
                        ),
                      ),
                      Container(
                        width: size.height * 0.11,
                        height: size.height * 0.08,
                        child: Icon(
                          Icons.filter_list,
                          color: icon,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: size.width * 0.20,
                        height: size.height * 0.25,
                        decoration: new BoxDecoration(
                          color: buttonBackground,
                          borderRadius: new BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: iconButton,
                              size: 38,
                            ),
                            Text(
                              "Vol",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: text,
                                fontSize: 24,
                              ),
                            ),
                            Icon(
                              Icons.remove,
                              color: iconButton,
                              size: 38,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        decoration: new BoxDecoration(
                          gradient: new LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.blue,
                              Colors.pink,
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(18),
                          width: size.width * 0.4,
                          height: size.width * 0.4,
                          decoration: new BoxDecoration(
                            color: background,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.20,
                        height: size.height * 0.25,
                        decoration: new BoxDecoration(
                          color: buttonBackground,
                          borderRadius: new BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.keyboard_arrow_up,
                              color: iconButton,
                              size: 38,
                            ),
                            Text(
                              "Ch",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: text,
                                fontSize: 24,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: iconButton,
                              size: 38,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DragTarget(
                        builder: (context, list, list2) {
                          return Container(
                            padding: EdgeInsets.all(3),
                            width: size.width * 0.2,
                            height: size.width * 0.5,
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: AppColors.dpadDirectionBackground,
                              size: 48,
                            ),
                          );
                        },
                        onWillAccept: (item) {
                          debugPrint('↑↑↑↑↑↑↑↑↑↑');
                          this.willAcceptStream.add(-50);
                          _fuctionDrag("↑↑↑↑↑↑↑↑↑↑");
                          return false;
                        },
                        onLeave: (item) {
                          debugPrint('RESET');
                          this.willAcceptStream.add(0);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.23,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DragTarget(
                        builder: (context, list, list2) {
                          return Container(
                            padding: EdgeInsets.all(3),
                            width: size.width * 0.2,
                            height: size.width * 0.5,
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: AppColors.dpadDirectionBackground,
                              size: 48,
                            ),
                          );
                        },
                        onWillAccept: (item) {
                          debugPrint('←←←←←←←←←←');
                          this.willAcceptStream.add(-50);
                          _fuctionDrag("←←←←←←←←←←");
                          return false;
                        },
                        onLeave: (item) {
                          debugPrint('RESET');
                          this.willAcceptStream.add(0);
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(2.5),
                        width: size.width * 0.5,
                        height: size.width * 0.5,
                        decoration: new BoxDecoration(
                          gradient: new LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.pinkAccent,
                              Colors.blue,
                              Color(0xFF584BD2)
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(18),
                          width: size.width * 0.4,
                          height: size.width * 0.4,
                          decoration: new BoxDecoration(
                            color: background,
                            shape: BoxShape.circle,
                          ),
                          child: Draggable(
                            axis: null,
                            feedback: StreamBuilder(
                              initialData: 0,
                              stream: willAcceptStream,
                              builder: (context, snapshot) {
                                return Container(
                                  width: size.width * 0.4,
                                  height: size.width * 0.4,
                                  decoration: new BoxDecoration(
                                    color: (snapshot.data) > 0
                                        ? AppColors.dpadDragHoverBackground
                                        : (snapshot.data) == 0
                                            ? buttonBackground
                                            : AppColors.dpadDragHoverBackground,
                                    shape: BoxShape.circle,
                                  ),
                                );
                              },
                            ),
                            childWhenDragging: Container(),
                            child: Container(
                              width: size.width * 0.4,
                              height: size.width * 0.4,
                              decoration: new BoxDecoration(
                                color: buttonBackground,
                                shape: BoxShape.circle,
                              ),
                            ),
                            onDraggableCanceled: (v, f) => setState(
                              () {
                                this.willAcceptStream.add(0);
                              },
                            ),
                          ),
                        ),
                      ),
                      DragTarget(
                        builder: (context, list, list2) {
                          return Container(
                            padding: EdgeInsets.all(3),
                            width: size.width * 0.2,
                            height: size.width * 0.5,
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              color: AppColors.dpadDirectionBackground,
                              size: 48,
                            ),
                          );
                        },
                        onWillAccept: (item) {
                          debugPrint('→→→→→→→→→→');
                          this.willAcceptStream.add(50);
                          _fuctionDrag("→→→→→→→→→→");
                          return false;
                        },
                        onLeave: (item) {
                          debugPrint('RESET');
                          this.willAcceptStream.add(0);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DragTarget(
                        builder: (context, list, list2) {
                          return Container(
                            // padding: EdgeInsets.all(3),
                            width: size.width * 0.4,
                            // height: size.width * 0.1,
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.dpadDirectionBackground,
                              size: 48,
                            ),
                          );
                        },
                        onWillAccept: (item) {
                          debugPrint('↓↓↓↓↓↓↓↓↓↓↓');
                          this.willAcceptStream.add(-50);
                          _fuctionDrag("↓↓↓↓↓↓↓↓↓↓↓");
                          return false;
                        },
                        onLeave: (item) {
                          debugPrint('RESET');
                          this.willAcceptStream.add(0);
                        },
                      ),

                      // Icon(
                      //   Icons.keyboard_arrow_down,
                      //   color: Color(0xFF584BD2),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              print("Start Pressed");
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Icon(
                              Icons.rss_feed,
                              color: Color(0xFF584BD2),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print("Settings Pressed");
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Icon(
                              Icons.settings,
                              color: icon,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

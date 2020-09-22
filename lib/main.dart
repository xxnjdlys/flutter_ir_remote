import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ir_remote/IRKeys.dart';
import 'package:rxdart/rxdart.dart';

import 'package:ir_sensor_plugin/ir_sensor_plugin.dart';
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

  String _platformVersion = 'Unknown';
  bool _hasIrEmitter = false;
  String _getCarrierFrequencies = 'Unknown';
  int _irValue = IRKeys.TYPE_XIAOMI;

  @override
  void initState() {
    willAcceptStream = new BehaviorSubject<int>();
    willAcceptStream.add(0);
    super.initState();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    bool hasIrEmitter;
    String getCarrierFrequencies;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await IrSensorPlugin.platformVersion;
      hasIrEmitter = await IrSensorPlugin.hasIrEmitter;
      getCarrierFrequencies = await IrSensorPlugin.getCarrierFrequencies;
    } on PlatformException {
      platformVersion = 'Failed to get data in a platform.';
      hasIrEmitter = false;
      getCarrierFrequencies = 'None';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _hasIrEmitter = hasIrEmitter;
      _getCarrierFrequencies = getCarrierFrequencies;
    });
  }

  _changeFrequencies(int value) {
    switch (value) {
      case IRKeys.TYPE_XIAOMI:
        IrSensorPlugin.setFrequencies(IRKeys.HERTZ_XIAOMI);
        break;
      case IRKeys.TYPE_TMALL:
        IrSensorPlugin.setFrequencies(IRKeys.HERTZ_TMALL);
        break;
      case IRKeys.TYPE_HISENSE:
        IrSensorPlugin.setFrequencies(IRKeys.HERTZ_HISENSE_TV);
        break;
      case IRKeys.TYPE_SKYWORTH:
        IrSensorPlugin.setFrequencies(IRKeys.HERTZ_KUKAI_TV);
        break;
      default:
        IrSensorPlugin.setFrequencies(IRKeys.HERTZ_DEFAULT);
        break;
    }
  }

  _getIRCodeArray(String key) {
    return IRKeys.getIRCodeArray(_irValue, key);
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
                        // Icon(
                        //   Icons.personal_video,
                        //   color: select,
                        //   size: 28,
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 0.0,
                            top: 0.0,
                            right: 0.0,
                            bottom: 0.0,
                          ),
                          child: DropdownButton(
                              value: _irValue,
                              items: [
                                DropdownMenuItem(
                                  child: Text("小米"),
                                  value: IRKeys.TYPE_XIAOMI,
                                ),
                                DropdownMenuItem(
                                  child: Text("天猫"),
                                  value: IRKeys.TYPE_TMALL,
                                ),
                                DropdownMenuItem(
                                  child: Text("海信"),
                                  value: IRKeys.TYPE_HISENSE,
                                ),
                                DropdownMenuItem(
                                  child: Text("创维"),
                                  value: IRKeys.TYPE_SKYWORTH,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _irValue = value;
                                });
                                _changeFrequencies(value);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.12,
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
                      Tooltip(
                        message: "Power On/Off",
                        child: InkWell(
                          onTap: () async {
                            final String result =
                                await IrSensorPlugin.transmitListInt(
                                    list: _getIRCodeArray(IRKeys.KEY_POWER));
                            print("Power Pressed , $result");
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
                      ),
                      Tooltip(
                        message: "Home",
                        child: InkWell(
                          onTap: () async {
                            final String result =
                                await IrSensorPlugin.transmitListInt(
                                    list: _getIRCodeArray(IRKeys.KEY_HOME));
                            print("Power Pressed , $result");
                          },
                          child: Container(
                            width: size.height * 0.11,
                            height: size.height * 0.08,
                            child: Icon(
                              Icons.home,
                              color: icon,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: size.width * 0.60,
                        height: size.height * 0.07,
                        decoration: new BoxDecoration(
                          color: buttonBackground,
                          borderRadius: new BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Tooltip(
                              message: "Volume Up",
                              child: InkWell(
                                child: Icon(
                                  Icons.add,
                                  color: iconButton,
                                  size: 38,
                                ),
                                onTap: () async {
                                  final String result =
                                      await IrSensorPlugin.transmitListInt(
                                          list: _getIRCodeArray(
                                              IRKeys.KEY_VOLUME_UP));
                                  debugPrint(
                                      'Emitting  List Int Signal: $result');
                                },
                              ),
                            ),
                            Text(
                              "Vol",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: text,
                                fontSize: 24,
                              ),
                            ),
                            Tooltip(
                              message: "Volume Down",
                              child: InkWell(
                                child: Icon(
                                  Icons.remove,
                                  color: iconButton,
                                  size: 38,
                                ),
                                onTap: () async {
                                  final String result =
                                      await IrSensorPlugin.transmitListInt(
                                          list: _getIRCodeArray(
                                              IRKeys.KEY_VOLUME_DOWN));
                                  debugPrint(
                                      'Emitting  List Int Signal: $result');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DragTarget(
                        builder: (context, list, list2) {
                          return Container(
                            padding: EdgeInsets.all(3),
                            width: size.width * 0.2,
                            height: size.width * 0.5,
                            child: Tooltip(
                              message: "Dpad Up",
                              child: InkWell(
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: AppColors.dpadDirectionBackground,
                                  size: 72,
                                ),
                                onTap: () async {
                                  final String result =
                                      await IrSensorPlugin.transmitListInt(
                                          list: _getIRCodeArray(
                                              IRKeys.KEY_DPAD_UP));
                                  debugPrint(
                                      'Emitting  List Int Signal: $result');
                                },
                              ),
                            ),
                          );
                        },
                        onWillAccept: (item) {
                          debugPrint('↑↑↑↑↑↑↑↑↑↑');
                          this.willAcceptStream.add(-50);
                          IrSensorPlugin.transmitListInt(
                            list: _getIRCodeArray(IRKeys.KEY_DPAD_UP),
                          );
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
                            child: Tooltip(
                              message: "Dpad Left",
                              child: InkWell(
                                child: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: AppColors.dpadDirectionBackground,
                                  size: 72,
                                ),
                                onTap: () async {
                                  final String result =
                                      await IrSensorPlugin.transmitListInt(
                                    list: _getIRCodeArray(IRKeys.KEY_DPAD_LEFT),
                                  );
                                  debugPrint(
                                      'Emitting  List Int Signal: $result');
                                },
                              ),
                            ),
                          );
                        },
                        onWillAccept: (item) {
                          debugPrint('←←←←←←←←←←');
                          this.willAcceptStream.add(-50);
                          IrSensorPlugin.transmitListInt(
                            list: _getIRCodeArray(IRKeys.KEY_DPAD_LEFT),
                          );
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
                            child: Tooltip(
                              message: "Dpad Right",
                              child: InkWell(
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: AppColors.dpadDirectionBackground,
                                  size: 72,
                                ),
                                onTap: () async {
                                  final String result =
                                      await IrSensorPlugin.transmitListInt(
                                    list:
                                        _getIRCodeArray(IRKeys.KEY_DPAD_RIGHT),
                                  );
                                  debugPrint(
                                      'Emitting  List Int Signal: $result');
                                },
                              ),
                            ),
                          );
                        },
                        onWillAccept: (item) {
                          debugPrint('→→→→→→→→→→');
                          this.willAcceptStream.add(50);
                          IrSensorPlugin.transmitListInt(
                            list: _getIRCodeArray(IRKeys.KEY_DPAD_RIGHT),
                          );
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
                            child: Tooltip(
                              message: "Dpad Down",
                              child: InkWell(
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.dpadDirectionBackground,
                                  size: 72,
                                ),
                                onTap: () async {
                                  final String result =
                                      await IrSensorPlugin.transmitListInt(
                                    list: _getIRCodeArray(IRKeys.KEY_DPAD_DOWN),
                                  );
                                  debugPrint(
                                      'Emitting  List Int Signal: $result');
                                },
                              ),
                            ),
                          );
                        },
                        onWillAccept: (item) {
                          debugPrint('↓↓↓↓↓↓↓↓↓↓↓');
                          this.willAcceptStream.add(-50);
                          IrSensorPlugin.transmitListInt(
                            list: _getIRCodeArray(IRKeys.KEY_DPAD_DOWN),
                          );
                          return false;
                        },
                        onLeave: (item) {
                          debugPrint('RESET');
                          this.willAcceptStream.add(0);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Tooltip(
                            message: "Back",
                            child: InkWell(
                              onTap: () {
                                print("Start Pressed");
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Icon(
                                Icons.rotate_right,
                                color: icon,
                              ),
                            ),
                          ),
                          Tooltip(
                            message: "Dpad Center",
                            child: InkWell(
                              onTap: () async {
                                final String result =
                                    await IrSensorPlugin.transmitListInt(
                                  list: _getIRCodeArray(IRKeys.KEY_DPAD_CENTER),
                                );
                                debugPrint(
                                    'Emitting  List Int Signal: $result');
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Icon(
                                Icons.gamepad_rounded,
                                color: icon,
                              ),
                            ),
                          ),
                          Tooltip(
                            message: "Menu",
                            child: InkWell(
                              onTap: () async {
                                final String result =
                                    await IrSensorPlugin.transmitListInt(
                                  list: _getIRCodeArray(IRKeys.KEY_MENU),
                                );
                                debugPrint(
                                    'Emitting  List Int Signal: $result');
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Icon(
                                Icons.menu,
                                color: icon,
                              ),
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

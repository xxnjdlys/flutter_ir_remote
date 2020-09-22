import 'package:flutter_ir_remote/ir/hisense.dart';
import 'package:flutter_ir_remote/ir/xiaomi.dart';
import 'package:flutter_ir_remote/ir/tmall.dart';
import 'package:flutter_ir_remote/ir/skyworth.dart';

class IRKeys {
  static const int HERTZ_DEFAULT = 37990;
  static const int HERTZ_TMALL = 37880;
  static const int HERTZ_XIAOMI = 38190;
  static const int HERTZ_KONGKA = 37890;
  static const int HERTZ_LETV_BOX = 37630;
  static const int HERTZ_HISENSE_TV = 37810;
  static const int HERTZ_KUKAI_TV = 38160;

  static const TYPE_XIAOMI = 0;
  static const TYPE_TMALL = 1;
  static const TYPE_HISENSE = 2;
  static const TYPE_SKYWORTH = 3;

  static const String KEY_POWER = "key_power";
  static const String KEY_MENU = "key_menu";
  static const String KEY_BACK = "key_back";
  static const String KEY_HOME = "key_home";
  static const String KEY_VOLUME_UP = "key_volume_up";
  static const String KEY_VOLUME_DOWN = "key_volume_down";
  static const String KEY_DPAD_CENTER = "key_dpad_center";
  static const String KEY_DPAD_UP = "key_dpad_up";
  static const String KEY_DPAD_DOWN = "key_dpad_down";
  static const String KEY_DPAD_LEFT = "key_dpad_left";
  static const String KEY_DPAD_RIGHT = "key_dpad_right";

  static const Map<String, List<int>> XiaoMiIRMap = {
    KEY_POWER: XiaoMi.POWER,
    KEY_MENU: XiaoMi.MENU,
    KEY_BACK: XiaoMi.BACK,
    KEY_HOME: XiaoMi.HOME,
    KEY_VOLUME_UP: XiaoMi.VOLUME_UP,
    KEY_VOLUME_DOWN: XiaoMi.VOLUME_DOWN,
    KEY_DPAD_CENTER: XiaoMi.CENTER,
    KEY_DPAD_UP: XiaoMi.UP,
    KEY_DPAD_DOWN: XiaoMi.DOWN,
    KEY_DPAD_LEFT: XiaoMi.LEFT,
    KEY_DPAD_RIGHT: XiaoMi.RIGHT,
  };

  static const Map<String, List<int>> TmallIRMap = {
    KEY_POWER: Tmall.POWER,
    KEY_MENU: Tmall.MENU,
    KEY_BACK: Tmall.BACK,
    KEY_HOME: Tmall.HOME,
    KEY_VOLUME_UP: Tmall.VOLUME_UP,
    KEY_VOLUME_DOWN: Tmall.VOLUME_DOWN,
    KEY_DPAD_CENTER: Tmall.CENTER,
    KEY_DPAD_UP: Tmall.UP,
    KEY_DPAD_DOWN: Tmall.DOWN,
    KEY_DPAD_LEFT: Tmall.LEFT,
    KEY_DPAD_RIGHT: Tmall.RIGHT,
  };

  static const Map<String, List<int>> HisenseIRMap = {
    KEY_POWER: Hisense.POWER,
    KEY_MENU: Hisense.MENU,
    KEY_BACK: Hisense.BACK,
    KEY_HOME: Hisense.HOME,
    KEY_VOLUME_UP: Hisense.VOLUME_UP,
    KEY_VOLUME_DOWN: Hisense.VOLUME_DOWN,
    KEY_DPAD_CENTER: Hisense.CENTER,
    KEY_DPAD_UP: Hisense.UP,
    KEY_DPAD_DOWN: Hisense.DOWN,
    KEY_DPAD_LEFT: Hisense.LEFT,
    KEY_DPAD_RIGHT: Hisense.RIGHT,
  };

  static const Map<String, List<int>> SkyworthIRMap = {
    KEY_POWER: Skyworth.POWER,
    KEY_MENU: Skyworth.MENU,
    KEY_BACK: Skyworth.BACK,
    KEY_HOME: Skyworth.HOME,
    KEY_VOLUME_UP: Skyworth.VOLUME_UP,
    KEY_VOLUME_DOWN: Skyworth.VOLUME_DOWN,
    KEY_DPAD_CENTER: Skyworth.CENTER,
    KEY_DPAD_UP: Skyworth.UP,
    KEY_DPAD_DOWN: Skyworth.DOWN,
    KEY_DPAD_LEFT: Skyworth.LEFT,
    KEY_DPAD_RIGHT: Skyworth.RIGHT,
  };

  static getIRCodeArray(int type, String key) {
    switch (type) {
      case IRKeys.TYPE_XIAOMI:
        switch (key) {
          case IRKeys.KEY_POWER:
            return XiaoMi.POWER;
            break;
          case IRKeys.KEY_MENU:
            return XiaoMi.MENU;
            break;
          case IRKeys.KEY_BACK:
            return XiaoMi.BACK;
            break;
          case IRKeys.KEY_HOME:
            return XiaoMi.HOME;
            break;
          case IRKeys.KEY_VOLUME_UP:
            return XiaoMi.VOLUME_UP;
            break;
          case IRKeys.KEY_VOLUME_DOWN:
            return XiaoMi.VOLUME_DOWN;
            break;
          case IRKeys.KEY_DPAD_CENTER:
            return XiaoMi.CENTER;
            break;
          case IRKeys.KEY_DPAD_UP:
            return XiaoMi.UP;
            break;
          case IRKeys.KEY_DPAD_DOWN:
            return XiaoMi.DOWN;
            break;
          case IRKeys.KEY_DPAD_LEFT:
            return XiaoMi.LEFT;
            break;
          case IRKeys.KEY_DPAD_RIGHT:
            return XiaoMi.RIGHT;
            break;
        }
        break;
      case IRKeys.TYPE_TMALL:
        switch (key) {
          case IRKeys.KEY_POWER:
            return Tmall.POWER;
            break;
          case IRKeys.KEY_MENU:
            return Tmall.MENU;
            break;
          case IRKeys.KEY_BACK:
            return Tmall.BACK;
            break;
          case IRKeys.KEY_HOME:
            return Tmall.HOME;
            break;
          case IRKeys.KEY_VOLUME_UP:
            return Tmall.VOLUME_UP;
            break;
          case IRKeys.KEY_VOLUME_DOWN:
            return Tmall.VOLUME_DOWN;
            break;
          case IRKeys.KEY_DPAD_CENTER:
            return Tmall.CENTER;
            break;
          case IRKeys.KEY_DPAD_UP:
            return Tmall.UP;
            break;
          case IRKeys.KEY_DPAD_DOWN:
            return Tmall.DOWN;
            break;
          case IRKeys.KEY_DPAD_LEFT:
            return Tmall.LEFT;
            break;
          case IRKeys.KEY_DPAD_RIGHT:
            return Tmall.RIGHT;
            break;
        }
        break;
      case IRKeys.TYPE_HISENSE:
        switch (key) {
          case IRKeys.KEY_POWER:
            return Hisense.POWER;
            break;
          case IRKeys.KEY_MENU:
            return Hisense.MENU;
            break;
          case IRKeys.KEY_BACK:
            return Hisense.BACK;
            break;
          case IRKeys.KEY_HOME:
            return Hisense.HOME;
            break;
          case IRKeys.KEY_VOLUME_UP:
            return Hisense.VOLUME_UP;
            break;
          case IRKeys.KEY_VOLUME_DOWN:
            return Hisense.VOLUME_DOWN;
            break;
          case IRKeys.KEY_DPAD_CENTER:
            return Hisense.CENTER;
            break;
          case IRKeys.KEY_DPAD_UP:
            return Hisense.UP;
            break;
          case IRKeys.KEY_DPAD_DOWN:
            return Hisense.DOWN;
            break;
          case IRKeys.KEY_DPAD_LEFT:
            return Hisense.DOWN;
            break;
          case IRKeys.KEY_DPAD_RIGHT:
            return Hisense.RIGHT;
            break;
        }
        break;
      case IRKeys.TYPE_SKYWORTH:
        switch (key) {
          case IRKeys.KEY_POWER:
            return Skyworth.POWER;
            break;
          case IRKeys.KEY_MENU:
            return Skyworth.MENU;
            break;
          case IRKeys.KEY_BACK:
            return Skyworth.BACK;
            break;
          case IRKeys.KEY_HOME:
            return Skyworth.HOME;
            break;
          case IRKeys.KEY_VOLUME_UP:
            return Skyworth.VOLUME_UP;
            break;
          case IRKeys.KEY_VOLUME_DOWN:
            return Skyworth.VOLUME_DOWN;
            break;
          case IRKeys.KEY_DPAD_CENTER:
            return Skyworth.CENTER;
            break;
          case IRKeys.KEY_DPAD_UP:
            return Skyworth.UP;
            break;
          case IRKeys.KEY_DPAD_DOWN:
            return Skyworth.DOWN;
            break;
          case IRKeys.KEY_DPAD_LEFT:
            return Skyworth.LEFT;
            break;
          case IRKeys.KEY_DPAD_RIGHT:
            return Skyworth.RIGHT;
            break;
        }
        break;
    }
  }
}

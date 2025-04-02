import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final String keyAvatar = 'avatar';
  static late SharedPreferences _prefs;

  Future<String?> getAvatarPath() async {
    SharedPreferences prefs = _prefs;
    String? avatarPath = prefs.getString(keyAvatar);
    return avatarPath;
  }

  Future<void> saveAvatarPath(String avatarPath) async {
    SharedPreferences prefs = _prefs;
    prefs.setString(keyAvatar, avatarPath);
  }
  static const String accessTokenKey = 'accessToken';

  // static String? get token {
  //   return _prefs.getString(accessTokenKey);
  // }

  static bool get isLogin =>
      _prefs.getString(accessTokenKey)?.isNotEmpty ?? false;


  static Future<void> initialise() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isAccessed {
    return _prefs.getBool('checkAccess') ?? false;
  }

  static set isAccessed(bool value) => _prefs.setBool('checkAccess', value);

  static removeSeason() {
    _prefs.remove(accessTokenKey);
  }

}


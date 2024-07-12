import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/strings.dart';

class InitialEntryService {
  static Future<void> initializer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(Strings.firstTimeKey, true);
  }
}

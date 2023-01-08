import 'dart:async';

import 'package:flutter_application_1/Model/user_info.dart';

class OnlineTime extends UserInfo {
  setOnlineTime() async {
    if (auth.currentUser != null) {
      DateTime nowTime = DateTime.now();
      final thrtyDaysFromNow =
          nowTime.add(const Duration(seconds: 30)).toString();
      await setUserUpdate({"online": thrtyDaysFromNow});

      Timer.periodic(const Duration(seconds: 25), (Timer t) async {
        DateTime nowTime = DateTime.now();
        final thrtyDaysFromNow =
            nowTime.add(const Duration(seconds: 30)).toString();
        try {
          await setUserUpdate({"online": thrtyDaysFromNow});
        } catch (e) {
          print(e);
        }
      });
    }
  }

  getOnlineStatus(String time) {
    DateTime nowTime = DateTime.now();
    DateTime userTime = DateTime.parse(time);
    var chack = userTime.difference(nowTime).inSeconds;

    if (chack <= 0) {
      return false;
    } else {
      return true;
    }
  }
}

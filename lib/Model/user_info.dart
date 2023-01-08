import 'package:flutter_application_1/Model/instances.dart';

class UserInfo extends Instances {
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      var getCillection =
          firestore.collection("users").doc(auth.currentUser!.phoneNumber);
      var docRef = await getCillection.get();
      return docRef.data();
    } catch (e) {
      return {"eror": e};
    }
  }

  Future<Map<String, dynamic>?> setUserUpdate(data) async {
    try {
      var getCillection =
          firestore.collection("users").doc(auth.currentUser!.phoneNumber);
      await getCillection.update(data);
      return {"update": true};
    } catch (e) {
      return {"error": e};
    }
  }
}

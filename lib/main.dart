import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/app.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

  Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyShared.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAQezECyHs98zQyQGaBJmBkpiyMDV76FmU",
      appId: "1:81808953758:android:ef4e0e6e85c0ad4fa3c68f",
      messagingSenderId: "81808953758",
      projectId: "momayaz-e90a5",
      storageBucket: "momayaz-e90a5.appspot.com",
    ),
  );
  safePrint(MyShared.getString(key: MySharedKeys.userid));
  runApp(const MyApp());
}

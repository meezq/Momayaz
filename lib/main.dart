import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/app.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyShared.init();
  await Firebase.initializeApp();
  safePrint(MyShared.getString(key: MySharedKeys.userid));
  runApp(const MyApp());
}


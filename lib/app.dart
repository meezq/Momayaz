import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/features/login/view/screens/login_screen.dart';
import 'package:momayaz/features/main/view/screens/main_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';
import 'package:momayaz/core/shared/my_shared.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
          ),
          home: MyShared.getString(key: MySharedKeys.userid).isEmpty
              ? LoginScreen()
              : const MainScreen(),
        );
      },
    );
  }
}

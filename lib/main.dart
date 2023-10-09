import 'package:flutter/material.dart';
import 'package:post_maker_application/screens/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Post Maker',
            theme: ThemeData(primarySwatch: Colors.blueGrey),
            home: SplashScreen(),
          );
        });
  }
}

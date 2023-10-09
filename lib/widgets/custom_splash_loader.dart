import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSplashLoader extends StatefulWidget {
  const CustomSplashLoader({Key? key}) : super(key: key);

  @override
  State<CustomSplashLoader> createState() => _CustomSplashLoaderState();
}

class _CustomSplashLoaderState extends State<CustomSplashLoader>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeIn);
    _animationController!.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animation!,
        child: Image(
          image: AssetImage("assets/images/splash_image.jpeg"),
          height: 50.w,
          width: 50.w,
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:post_maker_application/widgets/custom_splash_loader.dart';

class CustomLoaderComponent extends StatelessWidget {
  final bool? inButton;
  final double? loaderSize;
  final Color? loaderColor;
  final bool? isSplashLoading;

  CustomLoaderComponent(
      {this.inButton = false,
      @required this.loaderSize,
      this.loaderColor,
      this.isSplashLoading = false});

  @override
  Widget build(BuildContext context) {
    return isSplashLoading!
        ? Center(child: CustomSplashLoader())
        : Container(
            height: inButton! ? 20.0 : null,
            width: inButton! ? 40.0 : null,
            child: SpinKitThreeInOut(
              color:
                  loaderColor ?? Theme.of(context).appBarTheme.backgroundColor,
              size: loaderSize!.sp,
            ),
          );
  }
}

import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class TemplateScreen extends StatelessWidget {
  final String? templateImage;
  final String? imagePath;
  final String? text;
  final double? namePositionSize;
  final double? imageTopPosition;
  final double? imageBottomPosition;
  final GlobalKey _globalKey = GlobalKey();
  final String? appTitleName;

  TemplateScreen(
      {super.key,
      this.imagePath,
      this.text,
      this.templateImage,
      this.imageTopPosition,
      this.imageBottomPosition,
      this.namePositionSize,
      this.appTitleName});

  Future<void> _saveAndDownload(GlobalKey key, BuildContext context) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final result = await ImageGallerySaver.saveImage(pngBytes);

    if (result['isSuccess']) {
      final snackBar = SnackBar(
        content: Text('Downloaded successfully. Tap to open.'),
        duration: Duration(seconds: 10),
        dismissDirection: DismissDirection.startToEnd,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 700.r, left: 7.r, right: 7.r),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () async {
            if (Platform.isAndroid) {
              final AndroidIntent intent = AndroidIntent(
                action: 'action_view',
                type: 'image/*',
                package: 'com.android.gallery3d',
                data: result['filePath'], // This is the path to the saved image
              );
              await intent.launch();
            }
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text('Download failed'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appTitleName!)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: RepaintBoundary(
                key: _globalKey,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset(templateImage!),
                    Positioned(
                      top: imageTopPosition,
                      bottom: imageBottomPosition,
                      child: Image.file(
                        File(imagePath!),
                        height: 160.h,
                        width: 135.w,
                      ),
                    ),
                    Positioned(
                      bottom: namePositionSize,
                      child: Text(text!,
                          style: TextStyle(
                            fontFamily: 'Young_Serif',
                            fontSize: 24,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                            shadows: [
                              Shadow(
                                // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: Colors.black,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _saveAndDownload(_globalKey, context);
                },
                child: Text('Download'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

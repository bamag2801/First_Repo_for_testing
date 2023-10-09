import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

class ExperienceTemplateScreen extends StatelessWidget {
  final String? appTitleName;
  final String? templateImage;
  final String? experience;
  final String? text;
  final GlobalKey _globalKey = GlobalKey();

  ExperienceTemplateScreen(
      {super.key,
      this.experience,
      this.text,
      this.templateImage,
      this.appTitleName});

  Future<void> _saveAndDownload(GlobalKey key, BuildContext context) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Increase the pixelRatio for better image quality.
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final result = await ImageGallerySaver.saveImage(pngBytes);

    // Check if the result indicates success
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

  String getNumberSuffix(int number) {
    switch (number) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
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
                      top: 185.r,
                      // Adjust based on where you want to position the text
                      child: Text("$experience",
                          style: TextStyle(
                            fontFamily: 'Young_Serif',
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            shadows: [
                              Shadow(
                                  // bottomLeft
                                  offset: Offset(-0.8, -0.8),
                                  color: Colors.black54,
                                  blurRadius: 3),
                            ],
                          )),
                    ),
                    Positioned(
                      top: 300.r,
                      child: Column(
                        children: [
                          Text(
                            "Congratulations on your",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Young_Serif',
                              fontSize: 16,
                              color: Colors.blueGrey,
                              shadows: [
                                Shadow(
                                    // bottomLeft
                                    offset: Offset(-0.8, -0.8),
                                    color: Colors.black54,
                                    blurRadius: 3),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "$experience",
                                    style: TextStyle(
                                      fontFamily: 'Young_Serif',
                                      fontSize: 18,
                                      color: Colors.blueGrey,
                                      shadows: [
                                        Shadow(
                                            // bottomLeft
                                            offset: Offset(-0.8, -0.8),
                                            color: Colors.black54,
                                            blurRadius: 3),
                                      ],
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: const Offset(1, -7),
                                      child: Text(
                                        getNumberSuffix(int.parse(experience!)),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Young_Serif',
                                          fontSize: 14,
                                          color: Colors.blueGrey,
                                          shadows: [
                                            Shadow(
                                                // bottomLeft
                                                offset: Offset(-0.8, -0.8),
                                                color: Colors.black54,
                                                blurRadius: 3),
                                          ],
                                        ),
                                        //superscript is usually smaller in size
                                        textScaleFactor: 0.6,
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                              Text(
                                " Year Anniversary",
                                style: TextStyle(
                                  fontFamily: 'Young_Serif',
                                  fontSize: 16,
                                  color: Colors.blueGrey,
                                  shadows: [
                                    Shadow(
                                        // bottomLeft
                                        offset: Offset(-0.8, -0.8),
                                        color: Colors.black54,
                                        blurRadius: 3),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 240.r,
                      child: Text(
                        text!,
                        style: TextStyle(
                          letterSpacing: 0.8,
                          fontFamily: 'Young_Serif',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: Colors.black54,
                                blurRadius: 5),
                          ],
                          color: Color.fromRGBO(128, 0, 0, 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  await _saveAndDownload(_globalKey, context);
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

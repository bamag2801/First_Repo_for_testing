import 'package:flutter/material.dart';

class BuildTemplateScreen extends StatefulWidget {
  const BuildTemplateScreen({Key? key}) : super(key: key);

  @override
  State<BuildTemplateScreen> createState() => _BuildTemplateScreenState();
}

class _BuildTemplateScreenState extends State<BuildTemplateScreen> {
  final Map<String, dynamic> data = {
    "template": "assets/images/medyaan_birthday_wishes.png",
    "image": {
      "1": {
        "src": "assets/images/baby_image.png",
        "width": 90.0,
        "height": 90.0,
        "position": {"top": 50.0, "bottom": 30.0, "left": 50.0, "right": 30.0}
      },
      "2": {
        "src": "assets/images/baby_image.png",
        "width": 50.0,
        "height": 50.0,
        "position": {"top": 10.0, "bottom": 10.0, "left": 10.0, "right": 10.0}
      },
    },
    "text": {
      "1": {
        "fontsize": 15.0,
        "fontcolour": Colors.pink,
        "title": "Bama",
        "position": {"top": 100.0, "bottom": 30.0, "left": 50.0, "right": 30.0}
      },
      "2": {
        "fontsize": 15.0,
        "fontcolour": Colors.blue,
        "title": "Bams",
        "position": {"top": 100.0, "bottom": 30.0, "left": 50.0, "right": 30.0}
      }
    }
  };

  List<Widget> buildImages() {
    print("${data.length} +++bams");
    print("${data['image'].length}++++bama");
    List<Widget> imageWidgets = [];
    for (var i = 1; i <= data['image'].length; i++) {
      var imageInfo = data['image']['$i'];
      var positionInfo = imageInfo['position'];
      imageWidgets.add(
        Positioned(
          top: positionInfo['top'],
          left: positionInfo['left'],
          child: Image.asset(
            imageInfo['src'],
            width: imageInfo['width'],
            height: imageInfo['height'],
          ),
        ),
      );
    }
    return imageWidgets;
  }

  List<Widget> buildTexts() {
    List<Widget> textWidgets = [];
    for (var i = 1; i <= data['text'].length; i++) {
      var textInfo = data['text']['$i'];
      var positionInfo = textInfo['position'];
      textWidgets.add(
        Positioned(
          top: positionInfo['top'],
          left: positionInfo['left'],
          child: Text(
            textInfo['title'],
            style: TextStyle(
              fontSize: textInfo['fontsize'],
              color: textInfo['fontcolour'],
            ),
          ),
        ),
      );
    }
    return textWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Template'),
      ),
      body: Stack(
        children: [
          // Display template image
          Image.asset(
            data['template'],
            width: 200.0,
            height: 200.0,
          ),
          SizedBox(height: 20.0),
          Stack(
            children: buildImages(),
          ),
          Stack(
            children: buildTexts(),
          )
        ],
      ),
    );
  }
}

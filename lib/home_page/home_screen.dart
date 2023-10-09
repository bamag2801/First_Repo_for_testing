import 'dart:io';
import 'package:flutter/material.dart';
import 'package:post_maker_application/constants/regExpression.dart';
import 'package:post_maker_application/screens/experience_template_screen.dart';
import 'package:post_maker_application/screens/template_screen.dart';
import 'package:post_maker_application/widgets/customDropDownWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_maker_application/widgets/custom_button_widget.dart';
import 'package:post_maker_application/widgets/input_box_widget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _companyController = new TextEditingController();
  TextEditingController _wishesController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _experienceController = new TextEditingController();

  XFile? _pickedImage;

  dynamic validateName(String value) {
    if (RegExpression.validateSpecialCharacter(value)) {
      return "Name should not contain special characters";
    } else if (RegExpression.validateAtLeastOneDigit(value)) {
      return "Name should not contain numbers";
    } else {
      return null;
    }
  }

  final Color backgroundColorLight = Color(0xFFFFFFFF);

  final ButtonStyle elevatedButtonStyle_20_6 = ElevatedButton.styleFrom(
    elevation: 0.0,
    backgroundColor: Colors.blueGrey,
    padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 6.sp),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );
  final TextStyle buttonTextStyle_12 = TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.w500, color: Color(0xffffffff));
  final _formKey = GlobalKey<FormState>();

  String isAnniversary = "Anniversary wishes";
  String isBirthDayWishes = "Birthday wishes";

  Future<void> _pickImage() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: selectedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 5.5, ratioY: 5.1),
        maxWidth: 1920,
        maxHeight: 1080, // Adjust as needed
      );

      if (croppedFile != null) {
        setState(() {
          _pickedImage = XFile(croppedFile.path);
        });
      }
    }
  }

  void navigateToSelectedWishScreen() {
    if (_companyController.text == "Datayaan" &&
        _wishesController.text == "Birthday wishes") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TemplateScreen(
                appTitleName: "Datayaan Birthday Wishes",
                imageTopPosition: 31.r,
                imageBottomPosition: 85.r,
                namePositionSize: 215.r,
                templateImage: "assets/images/datayaan_birthday_wishes.png",
                imagePath: _pickedImage!.path,
                text: _nameController.text.isEmpty
                    ? ""
                    : _nameController.text[0].toUpperCase() +
                        _nameController.text.substring(1)),
          ));
    } else if (_companyController.text == "Datayaan" &&
        _wishesController.text == "Anniversary wishes") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExperienceTemplateScreen(
                appTitleName: "Datayaan Anniversary Wishes",
                templateImage: "assets/images/datayaan_work_anniversary.png",
                experience: _experienceController.text,
                text: _nameController.text.isEmpty
                    ? ""
                    : _nameController.text[0].toUpperCase() +
                        _nameController.text.substring(1)),
          )); // Adjusted this line
    } else if (_companyController.text == "Medyaan" &&
        _wishesController.text == "Birthday wishes") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TemplateScreen(
                appTitleName: "Medyaan Birthday Wishes",
                imageTopPosition: 45.r,
                imageBottomPosition: 85.r,
                namePositionSize: 205.r,
                imagePath: _pickedImage!.path,
                templateImage: "assets/images/medyaan_birthday_wishes.png",
                text: _nameController.text.isEmpty
                    ? ""
                    : _nameController.text[0].toUpperCase() +
                        _nameController.text.substring(1)),
          ));
    } else if (_companyController.text == "Medyaan" &&
        _wishesController.text == "Anniversary wishes") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExperienceTemplateScreen(
                appTitleName: "Medyaan Anniversary Wishes",
                templateImage: "assets/images/medyaan_work_anniversary.png",
                experience: _experienceController.text,
                text: _nameController.text.isEmpty
                    ? ""
                    : _nameController.text[0].toUpperCase() +
                        _nameController.text.substring(1)),
          ));
    }
  }

  void validation() {
    if (_formKey.currentState!.validate()) {
      if (_pickedImage == null && isBirthDayWishes == _wishesController.text) {
        final snackBar = SnackBar(content: Text('Please upload a image'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (_wishesController.text == "Anniversary wishes") {
        navigateToSelectedWishScreen();
      } else {
        navigateToSelectedWishScreen();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text("Post Maker"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomDropDownWidget(
                      width: 328.w,
                      height: 40.h,
                      dropDownItems: ["Datayaan", "Medyaan"],
                      labelText: "Select a company",
                      emptyValidation: true,
                      emptyValidationText: "Company name",
                      requiredValidationText: "Company name",
                      currentItem: "",
                      chosenValue: (value) {
                        setState(() {
                          _companyController.text = value;
                        });
                      }),
                  CustomDropDownWidget(
                      width: 328.w,
                      height: 40.h,
                      dropDownItems: ["Birthday wishes", "Anniversary wishes"],
                      labelText: "Select a wish",
                      emptyValidationText: "Wish type",
                      emptyValidation: true,
                      requiredValidationText: "Wish type",
                      currentItem: "",
                      chosenValue: (value) {
                        setState(() {
                          _wishesController.text = value;
                        });
                      }),
              /*    InputBoxWidget(
                    height: 40.h,
                    width: 328.w,
                    suffixText: "",
                    hintText: "Enter a person name",
                    inputBoxController: _nameController,
                    labelText: "Person name",
                    validationLogic: (value) => validateName(value),
                    emptyValidationText: "Person name",
                    emptyValidation: true,
                    requiredValidationText: "Person name",
                  ),
                  isAnniversary == _wishesController.text
                      ? InputBoxWidget(
                          height: 40.h,
                          width: 328.w,
                          suffixText: "",
                          numberKeyboard: true,
                          hintText: "",
                          emptyValidation: true,
                          emptyValidationText: "Experience",
                          requiredValidationText: "Experience",
                          inputBoxController: _experienceController,
                          labelText: "Experience",
                          validationLogic: (value) {
                            _experienceController.text = value;
                          },
                        )
                      : SizedBox(),
                  isBirthDayWishes == _wishesController.text
                      ? Column(
                          children: [
                            CustomButton(
                              buttonFunction: () => _pickImage(),
                              buttonText: "Upload a person Image",
                              elevatedButtonStyle: elevatedButtonStyle_20_6,
                              buttonTextStyle: buttonTextStyle_12,
                            ),
                            _pickedImage != null
                                ? Center(
                                    child: Image.file(
                                      File(_pickedImage!.path),
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        buttonFunction: () {
                          validation();
                        },
                        buttonText: "Next",
                        elevatedButtonStyle: elevatedButtonStyle_20_6,
                        buttonTextStyle: buttonTextStyle_12,
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post_maker_application/constants/functions.dart';

//call back to pass data to its parent widget
typedef void CustomDropDownCallback(String value);
typedef dynamic InputBoxCallback(String value);

class CustomDropDownWidget extends StatefulWidget {
  final List<String>? dropDownItems;
  final String? labelText;
  final double? width;
  final double? height;
  final CustomDropDownCallback? chosenValue;
  final String? currentItem;
  final bool emptyValidation;
  final String? emptyValidationText;
  final String? requiredValidationText;
  final InputBoxCallback? validationLogic;
  final bool? isRequiredField;
  final bool? isEnabled;
  var key;

  CustomDropDownWidget({
    @required this.dropDownItems,
    this.chosenValue,
    @required this.labelText,
    this.width,
    this.height,
    this.currentItem,
    this.emptyValidationText,
    this.emptyValidation = false,
    this.isRequiredField = false,
    this.requiredValidationText,
    this.isEnabled = true,
    this.validationLogic,
    this.key,
  });

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  String? selectValue;
  List<String>? dropDownItemList;

  void clearData() {
    setState(() {
      selectValue = null;
    });
  }

  @override
  void didUpdateWidget(covariant CustomDropDownWidget oldWidget) {
    if (widget.currentItem == null) {
      clearData();
    }

    super.didUpdateWidget(oldWidget);
  }

  final TextStyle inputBoxTextStyle =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var list = Set<String>();
    dropDownItemList =
        widget.dropDownItems!.where((item) => list.add(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      try {
        if (dropDownItemList!.isNotEmpty) {
          selectValue = widget.currentItem != null
              ? dropDownItemList!.firstWhere((element) =>
                  element.toLowerCase() == widget.currentItem!.toLowerCase())
              : selectValue;
        } else {
          selectValue = null;
        }
      } catch (e) {}
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: widget.isRequiredField!
                ? RichText(
                    text: TextSpan(children: [
                    TextSpan(
                      text: widget.labelText!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12.sp),
                    ),
                    TextSpan(
                        text: " *",
                        style: TextStyle(fontSize: 14.sp, color: Colors.red))
                  ]))
                : RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: widget.labelText!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12.sp),
                      )
                    ]),
                  )),
        Container(
          constraints: BoxConstraints(minHeight: widget.height!.h),
          width: widget.width!.w,
          child: Center(
              child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: const EdgeInsets.all(16.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              //focusColor: Theme.of(context).colorScheme.primary,
              value: selectValue,
              style: inputBoxTextStyle.copyWith(
                  color: Colors.black, overflow: TextOverflow.ellipsis),

              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.black,
              icon: Row(children: [
                VerticalDivider(
                  thickness: 1.0,
                  color: Colors.black,
                ),
                // SizedBox(
                //   width: 5.0.w,
                // ),
                Icon(FontAwesomeIcons.angleDown)
              ]),
              iconSize: 20.0,
              validator: (value) => widget.emptyValidation
                  ? value == null
                      ? "${widget.requiredValidationText} is required"
                      : null
                  : null,

              items: CommonFunctions.convertDropDownObject(dropDownItemList!),
              onChanged: widget.isEnabled!
                  ? (value) {
                      setState(() {
                        selectValue = value as String;
                      });
                      if (widget.chosenValue != null) {
                        widget.chosenValue!(selectValue!);
                      }
                    }
                  : null,
            ),
          )),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}

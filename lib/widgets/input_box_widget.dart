import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//callback for validation
typedef dynamic InputBoxCallback(String value);
typedef dynamic SaveFunctionCallback(String saveValue);
typedef dynamic OnChangedCallback(String value);

class InputBoxWidget extends StatefulWidget {
  final Key? key;
  final double? height;
  final double? width;
  final String? suffixText;
  final String? labelText;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final SaveFunctionCallback? onSaveFunction;
  final InputBoxCallback? validationLogic;
  final OnChangedCallback? onChangedCallback;
  final TextEditingController? inputBoxController;
  final bool isPassword;
  final bool numberKeyboard;
  final bool emptyValidation;
  final String? emptyValidationText;
  final String? requiredValidationText;
  final bool? autoValidation;
  final bool? isSuffixNeeded;
  final bool? isRequiredField;
  final bool? isEnabled;
  final String? regExp;
  final int? numberLimit;

  InputBoxWidget(
      {this.key,
      this.height,
      this.width,
      this.suffixText = "",
      this.labelText = "",
      this.hintText = "",
      this.maxLines,
      this.minLines,
      this.validationLogic,
      this.onChangedCallback,
      this.onSaveFunction,
      this.inputBoxController,
      this.isPassword = false,
      this.numberKeyboard = false,
      this.emptyValidation = true,
      this.emptyValidationText,
      this.requiredValidationText,
      this.autoValidation = true,
      this.isSuffixNeeded = true,
      this.isRequiredField = false,
      this.isEnabled = true,
      this.regExp,
      this.numberLimit = 10});

  @override
  State<InputBoxWidget> createState() => _InputBoxWidgetState();
}

class _InputBoxWidgetState extends State<InputBoxWidget> {
  final Color textBoxLabel = Color.fromRGBO(0, 0, 0, 0.6);
  final Color emergencyButtonColor = Color.fromRGBO(255, 0, 0, 1);
  final Color textLight = Color.fromRGBO(0, 0, 0, 0.87);
  final Color textBoxBackground = Color(0xffF3F3F3);
  final Color suffixTextLight = Color.fromRGBO(166, 166, 166, 0.87);

  final TextStyle inputBoxTextStyle =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);

  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: widget.isRequiredField!
              ? RichText(
                  text: TextSpan(children: [
                  TextSpan(
                    text: widget.labelText!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textBoxLabel,
                        fontSize: 12.sp),
                  ),
                  TextSpan(
                      text: " *",
                      style: TextStyle(
                          fontSize: 14.sp, color: emergencyButtonColor))
                ]))
              : RichText(
                  text: TextSpan(children: [
                  TextSpan(
                    text: widget.labelText!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textBoxLabel,
                        fontSize: 12.sp),
                  )
                ]))),
      SizedBox(height: 5.h),
      Container(
          constraints: BoxConstraints(minHeight: 55.h),
          width: widget.width!.h,
          child: TextFormField(
              onChanged: (value) {
                if (widget.onChangedCallback != null) {
                  widget.onChangedCallback!(value);
                }
              },
              enabled: widget.isEnabled,
              onSaved: (saveValue) {
                widget.onSaveFunction!(saveValue!);
              },
              onFieldSubmitted: widget.validationLogic,
              autovalidateMode: widget.autoValidation!
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              keyboardType: widget.numberKeyboard
                  ? TextInputType.numberWithOptions(
                      decimal: true, signed: false)
                  : TextInputType.visiblePassword,
              inputFormatters: [
                widget.numberKeyboard
                    ? LengthLimitingTextInputFormatter(1)
                    : LengthLimitingTextInputFormatter(20),
                widget.numberKeyboard
                    ? FilteringTextInputFormatter.deny(RegExp(r'[,\-\]]'))
                    : FilteringTextInputFormatter(RegExp(r'^[\u0020-\u007E]+$'),
                        allow: true)
              ],
              validator: (value) {
                if (widget.emptyValidation) {
                  if (value!.isEmpty) {
                    return widget.emptyValidationText != null
                        ? "${widget.requiredValidationText} is required"
                        : "Field is required";
                  } else {
                    return widget.validationLogic!(value);
                  }
                } else {
                  if (value!.isNotEmpty) {
                    return widget.validationLogic!(value);
                  }
                }
              },
              controller: widget.inputBoxController,
              style: inputBoxTextStyle.copyWith(
                  color: textLight, overflow: TextOverflow.ellipsis),
              cursorColor: textLight,
              cursorWidth: 1.0,
              obscureText: widget.isPassword ? isPasswordVisible : false,
              decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: emergencyButtonColor),
                      borderRadius: BorderRadius.circular(4.0)),
                  errorStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: emergencyButtonColor),
                  hintText: widget.hintText,
                  filled: true,
                  fillColor: textBoxBackground,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textBoxBackground),
                      borderRadius: BorderRadius.circular(4.0)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: textBoxBackground),
                      borderRadius: BorderRadius.circular(4.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(4.0)),
                  suffixIcon: widget.isSuffixNeeded!
                      ? widget.isPassword
                          ? IconButton(
                              splashRadius: 1.0,
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 18.0,
                              ),
                              onPressed: () => setState(
                                  () => isPasswordVisible = !isPasswordVisible))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text(
                                    widget.suffixText!,
                                    style: TextStyle(
                                        color: suffixTextLight,
                                        fontSize: 14.sp),
                                  )
                                ])
                      : null))),
      SizedBox(height: 8.0)
    ]));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_maker_application/widgets/custom_loader_component.dart';

class CustomButton extends StatelessWidget {
  final Key? key;
  final buttonFunction;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final bool isIconAvailable;
  final IconData? iconData;
  final ButtonStyle? elevatedButtonStyle;
  final bool isLoading;
  final bool isDisabledText;
  final bool disabledButton;

  CustomButton({
    this.key,
    @required this.buttonFunction,
    @required this.buttonText,
    @required this.buttonTextStyle,
    @required this.elevatedButtonStyle,
    this.isIconAvailable = false,
    this.iconData,
    this.isLoading = false,
    this.isDisabledText = false,
    this.disabledButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return isIconAvailable
        ? disabledButton
            ? ElevatedButton.icon(
                style: elevatedButtonStyle!.copyWith(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                  splashFactory: null,
                ),
                onPressed: null,
                icon: Icon(iconData, size: 15.r),
                label: Container(
                    constraints:
                        BoxConstraints(minHeight: 20.0, minWidth: 50.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(buttonText!,
                              style: buttonTextStyle,
                              textAlign: TextAlign.center)
                        ])))
            : ElevatedButton.icon(
                style: elevatedButtonStyle!.copyWith(
                  backgroundColor: isLoading
                      ? MaterialStateProperty.all(Colors.grey)
                      : MaterialStateProperty.all(Colors.blueGrey),
                  splashFactory: isLoading ? NoSplash.splashFactory : null,
                ),
                onPressed: isLoading ? () {} : buttonFunction,
                icon: Icon(
                  iconData,
                  size: 15.r,
                ),
                label: Container(
                  constraints: BoxConstraints(minHeight: 20.0, minWidth: 50.0),
                  child: isLoading
                      ? isDisabledText
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  buttonText!,
                                  style: buttonTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : CustomLoaderComponent(
                              inButton: true,
                              loaderSize: 20.0,
                              loaderColor: Colors.white,
                            )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              buttonText!,
                              style: buttonTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                ))
        : disabledButton
            ? ElevatedButton(
                style: elevatedButtonStyle!.copyWith(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                  splashFactory: null,
                ),
                onPressed: null,
                child: Container(
                  constraints: BoxConstraints(minHeight: 20.0, minWidth: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        buttonText!,
                        style: buttonTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : ElevatedButton(
                style: elevatedButtonStyle!.copyWith(
                  backgroundColor: isLoading
                      ? MaterialStateProperty.all(Colors.grey)
                      : MaterialStateProperty.all(Colors.blueGrey),
                  splashFactory: isLoading ? NoSplash.splashFactory : null,
                ),
                onPressed: isLoading ? () {} : buttonFunction,
                child: Container(
                  constraints: BoxConstraints(minHeight: 20.0, minWidth: 50.0),
                  child: isLoading
                      ? isDisabledText
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  buttonText!,
                                  style: buttonTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : CustomLoaderComponent(
                              inButton: true,
                              loaderSize: 20.0,
                              loaderColor: Colors.white,
                            )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              buttonText!,
                              style: buttonTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                ),
              );
  }
}

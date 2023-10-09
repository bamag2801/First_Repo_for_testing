import 'package:flutter/material.dart';

class CommonFunctions {
  static List<DropdownMenuItem<String>> convertDropDownObject(
          List<String> dropDownItems) =>
      dropDownItems
          .map((item) => DropdownMenuItem<String>(
                child: Text(item),
                value: item,
              ))
          .toList();
}

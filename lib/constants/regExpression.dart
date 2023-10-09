class RegExpression{
  static bool validateSpecialCharacter(String value) {
    String pattern = r'^(?=.*?[!@#\$&*~])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool validateAtLeastOneDigit(String value) {
    String pattern = r'^(?=.*?[0-9])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
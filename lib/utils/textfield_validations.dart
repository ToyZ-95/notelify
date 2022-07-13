class TextFieldValidations {
  TextFieldValidations._();

  static TextFieldValidations? _textFieldValidations;

  static TextFieldValidations get instance {
    return _textFieldValidations ?? TextFieldValidations._();
  }

  emailValidations(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    return;
  }

  passwordValidations(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    }
    return;
  }
}

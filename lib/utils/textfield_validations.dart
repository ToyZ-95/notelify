class TextFieldValidations {
  TextFieldValidations._();

  static TextFieldValidations? _textFieldValidations;

  static TextFieldValidations get instance {
    return _textFieldValidations ?? TextFieldValidations._();
  }

  fullNameValidations(String value) {
    if (value.isEmpty) {
      return "Full Name can't be empty";
    }
    return;
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

  confirmPasswordValidations(String value, String compareTo) {
    if (passwordValidations(value) == null) {
      if (value != compareTo) {
        return "Passwords must be same";
      }
    } else {
      return "Password can't be empty";
    }
  }
}

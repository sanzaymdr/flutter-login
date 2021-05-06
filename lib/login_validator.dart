class Validator {
  bool validateEmail(email) {
    if (email == null) {
      return false;
    }
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool validatePassword(password) {
    if (password == null) {
      return false;
    }
    if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  bool validatePhone(phone) {
    if (phone == null) {
      return false;
    }
    phone = phone.trim();
    if (RegExp(r'(^(?:\+977)?[0-9]{9,12}$)').hasMatch(phone)) {
      /*
      - ^ Start of string
      - (?:\+977)? Optionally match +977 followed by remaining
      - [0-9]{9,12} Match if digits only of length 9-12
      - $ End of string
      */
      return true;
    } else {
      return false;
    }
  }

  bool validatePin(String pin, int length) {
    pin = pin.trim();
    if (pin == null) {
      return false;
    } else {
      if (length != pin.length) {
        return false;
      } else {
        if (RegExp(r'^[0-9]+$').hasMatch(pin)) {
          //only numbers
          return true;
        } else {
          return false;
        }
      }
    }
  }
}

class AuthValidator {
  static String? isEmailValid(String? text) {
    if (text != null && text.contains("@") && text.contains(".")) {
      return null;
    } else {
      return "L'indirizzo email non è valido";
    }
  }

  static String? isPasswordValid(String? text) {
    if (text != null) {
      return null;
    } else {
      return "La password non è valida";
    }
  }
}

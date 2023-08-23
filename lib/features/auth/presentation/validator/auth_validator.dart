class AuthValidator {
  static String? isEmailValid(String? text) {
    if (text != null && text.contains("@") && text.contains(".")) {
      return null;
    } else {
      return "L'indirizzo email non è valido";
    }
  }

  static String? isPasswordValid(String? text) {
    if (text != null && text.length > 8) {
      return null;
    } else {
      return "La password deve avere più di 8 caratteri";
    }
  }
}

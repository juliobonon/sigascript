abstract class Validators {
  String validateEmail(String email);
  String validatePassword(String password);
}

class Validator implements Validators {
  bool isValidEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }

  String validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email não pode ser vazio';
    } else if (isValidEmail(email) != true) {
      return 'Isso não parece ser um email';
    }
  }

  String validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password não pode ser vazio';
    }
  }

  String validateRG(String rg) {
    if (rg.isEmpty) {
      return 'RG não pode ser vazio';
    } else if (rg.length < 11) {
      return 'Digite seu RG com o digito';
    }
  }
}

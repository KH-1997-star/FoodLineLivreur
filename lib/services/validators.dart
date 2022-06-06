//import 'package:get/get_utils/get_utils.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get_utils/get_utils.dart';

///
/// class Global contain all validation  of the form
///
///
class Validators {
  const Validators._();

  static String? validateEmpty(String? v, String? txt) {
    if (v!.isEmpty) {
      return txt; //Const.fieldCantBeEmpty;
    } else {
      return null;
    }
  }

  static String? validateName(String? v) {
    if (v!.isEmpty) {
      return "*Champs Obligatoire";
    } else {
      return null;
    }
  }

  static String? validateTEmpty<T>(T? v) {
    if (v == null) {
      return "*Champs Obligatoire";
    } else {
      return null;
    }
  }

  static String? validateEmail(
    String? v,
  ) {
    if (v!.isEmpty) {
      return "*Champs Obligatoire"; //Const.fieldCantBeEmpty;
    } else if (!GetUtils.isEmail(v)) {
      return 'E-Mail invalide'; //Const.enterValidEmail;
    } else {
      return null;
    }
  }

  static String? validatePwd(
    String? v,
  ) {
    if (v!.isEmpty) {
      return "*Champs Obligatoire"; //Const.fieldCantBeEmpty;
    } else {
      return null;
    }
  }

  static String? validatePhone(String? v) {
    if (v!.isEmpty) {
      return "*Champs Obligatoire";
    } else {
      return null;
    }
  }

  static String? validateEmailPhone(
      String? v, String? txtempty, String? txtvalid) {
    if (v!.isEmpty) {
      return "*Champs Obligatoire";
    } else if (GetUtils.isNumericOnly(v)) {
      return validatePhone(v);
    } else {
      return validateEmail(v);
    }
  }

  static bool validateStructure(String? value) {
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value!);
  }

  static String? validatePassword(String v) {
    if (v.isEmpty) {
      return "*Champs Obligatoire"; //Const.fieldCantBeEmpty;
    } else if (v.length < 8) {
      return "Le mot de passe doit contenir au moins 8 caractères"; //Const.passwordValidation1;
    } else if (!validateStructure(v)) {
      return "Lettres, chiffres et caractères spéciaux";
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String v, String password) {
    if (v.isEmpty || password.isEmpty) {
      return "*Champs Obligatoire"; // Const.fieldCantBeEmpty;
    } else if (v.length < 8) {
      return "Le mot de passe doit contenir au moint 8 caractères"; //Const.passwordValidation;
    } else if (!validateStructure(v)) {
      return "Lettres, chiffres et caractères spéciaux";
    } else if (v.length < 8 || password.length < 8 || v != password) {
      return "Les mots de passes ne sont pas identiques"; // Const.confirmPasswordValidation;
    } else {
      return null;
    }
  }

  static String validateCheckbox({
    bool v = false,
    String error = "Const.checkboxValidation",
  }) {
    if (!v) {
      return error;
    } else {
      return "";
    }
  }
}

import 'package:user_profile_app/core/constants/constants.dart';

class Validators {
  static String? validateName(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'El $fieldName es requerido';
    } else if (value.length < minNameLength) {
      return 'Debe tener al menos 2 caracteres';
    } else if (value.length > maxNameLength) {
      return 'Máximo $maxNameLength caracteres';
    } else if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$').hasMatch(value)) {
      return 'Solo se permiten letras';
    }
    return null;
  }
}

bool isOnlyLetters(String value) {
  return RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$').hasMatch(value);
}
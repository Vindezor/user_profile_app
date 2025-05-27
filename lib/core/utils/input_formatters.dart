import 'package:flutter/services.dart';

class InputFormatters {
  static final nameOnly = FilteringTextInputFormatter.allow(
    RegExp(r"[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]"),
  );
}
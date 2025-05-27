import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_profile_app/core/theme/app_styles.dart';
import 'package:user_profile_app/core/utils/validators.dart';

class LabeledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String requiredMessage;

  const LabeledTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.requiredMessage,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: 30,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]")),
      ],
      validator: (value) => Validators.validateName(value, fieldName: "nombre"),
      decoration: InputDecoration(
        labelText: label,
        border: AppStyles.inputBorder
      ),
    );
  }
}
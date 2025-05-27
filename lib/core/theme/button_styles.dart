// core/theme/button_styles.dart

import 'package:flutter/material.dart';

class ButtonStyles {
  static ButtonStyle primaryRounded(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

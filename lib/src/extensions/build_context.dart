import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  Color get backgroud {
    return Theme.of(this).colorScheme.background;
  }

  Color get onBackground {
    return Theme.of(this).colorScheme.onBackground;
  }

  Color get primary {
    return Theme.of(this).colorScheme.primary;
  }

  Color get secondary {
    return Theme.of(this).colorScheme.secondary;
  }

  Color get tertiary {
    return Theme.of(this).colorScheme.tertiary;
  }

  Color get onError {
    return Theme.of(this).colorScheme.error;
  }

  Color get transparent {
    return Colors.transparent;
  }
}

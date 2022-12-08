import 'package:flutter/material.dart';

import './palette.dart';

ButtonStyle roundedButton = ButtonStyle(
  backgroundColor: const MaterialStatePropertyAll<Color>(Palette.pink),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder()),
);
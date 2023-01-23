import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final Function(String) onPressed;
  final controller;
  final keyboardType;
  const AdaptativeTextField(this.label, this.onPressed, this.controller, this.keyboardType);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: CupertinoTextField(
            controller: controller,
            onSubmitted: (_) => onPressed,
            placeholder: label,
            keyboardType: keyboardType,
          ),
        )
        : TextField(
            controller: controller,
            onSubmitted: (_) => onPressed,
            decoration: InputDecoration(
              labelText: label,
            ),
            keyboardType: keyboardType,
          );
  }
}

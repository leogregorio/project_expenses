import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime? selectedDate = null;
  final Function(DateTime)? onDateChanged = null;

  const AdaptativeDatePicker(
    selectedDate,
    onDateChanged,
    Key? key,
  ) : super(key: key);

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged!(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged!,
            ),
          )
        : Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? "Nenhuma data selecionada!"
                        : 'Data Selecionada: ${DateFormat('d/M/y').format(selectedDate!)}',
                  ),
                ),
                TextButton(
                    onPressed: _showDatePicker(context),
                    child: Text("Selecionar data",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          );
  }
}

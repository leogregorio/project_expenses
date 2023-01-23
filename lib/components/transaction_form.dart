import 'package:flutter/material.dart';
import 'package:project_expenses/components/adaptative_date_picker.dart';
import '../models/transaction.dart';
import 'adaptative_button.dart';
import 'package:intl/intl.dart';

import 'adaptative_textfield.dart';

class TransactionForm extends StatefulWidget {
  void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);
  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  //this._titleController, this._valueController);
  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    _valueController.text.replaceAll(',', '.');
    widget.onSubmit(title, value, _selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              10, 10, 10, 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                AdaptativeTextField('Título', _submitForm(), _titleController,
                    TextInputType.text),
                AdaptativeTextField(
                    'Valor (R\$)',
                    _submitForm(),
                    _valueController,
                    TextInputType.numberWithOptions(decimal: true)),
                // TextField(
                //   controller: _titleController,
                //   onSubmitted: (_) => _submitForm,
                //   decoration: InputDecoration(
                //     labelText: 'Título',
                //   ),
                // ),
                // TextField(
                //   controller: _valueController,
                //   keyboardType: TextInputType.numberWithOptions(decimal: true),
                //   onSubmitted: (_) => _submitForm,
                //   decoration: InputDecoration(
                //     labelText: 'Valor (R\$)',
                //   ),
                // ),
                AdaptativeDatePicker(_selectedDate, (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                }, null),
                // Container(
                //   height: 70,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Text(
                //           _selectedDate == null
                //               ? "Nenhuma data selecionada!"
                //               : 'Data Selecionada: ${DateFormat('d/M/y').format(_selectedDate!)}',
                //         ),
                //       ),
                //       TextButton(
                //           onPressed: _showDatePicker,
                //           child: Text("Selecionar data",
                //               style: TextStyle(fontWeight: FontWeight.bold))),
                //     ],
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    AdaptativeButton(
                      'Adicionar transação',
                      _submitForm,
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}

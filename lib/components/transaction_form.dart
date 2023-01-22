import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

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

  _showDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null)
      {
        return;
      }

      setState(() {
      _selectedDate = pickedDate;
        
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm,
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null ? "Nenhuma data selecionada!":
                          'Data Selecionada: ${DateFormat('d/M/y').format(_selectedDate!)}',
                        ),
                  ),
                  TextButton( 
                      onPressed: _showDatePicker,
                      child: Text(
                        "Selecionar data",
                        style: TextStyle(fontWeight: FontWeight.bold)
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Adicionar transação',
                        )),
              ],
            )
          ]),
    );
  }
}

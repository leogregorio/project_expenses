import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {

  void Function (String,double) onSubmit;

  TransactionForm(this.onSubmit); 
  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

 //this.titleController, this.valueController);
  _submitForm() {

    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0)
    {
      return;
    }

    valueController.text.replaceAll(',', '.');    
    widget.onSubmit(title ,value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 5,
              child: Column (
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                TextField(
                  controller: titleController,
                  onSubmitted: (_) => _submitForm,
                  decoration: InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                TextField(
                  controller: valueController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitForm,
                  decoration: InputDecoration(
                    labelText: 'Valor (R\$)',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    TextButton(
                    onPressed: _submitForm ,                                 
                    child: 
                      Text('Adicionar transação',
                        style: TextStyle( 
                          color: Theme.of(context).colorScheme.primary,)
                      )
                    ),
             
                  ],
                )
              ]),
            );
  }
}
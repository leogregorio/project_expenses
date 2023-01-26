import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Transaction_item extends StatelessWidget {
  const Transaction_item({
    Key? key,
    required this.onRemove,
    required this.tr,
  }) : super(key: key);

  final void Function(String p1) onRemove;
  final Transaction tr;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => onRemove(tr.id),
                icon: Icon(Icons.delete_rounded),
                label: const Text('Excluir')
              )
            : IconButton(
                icon: Icon(Icons.delete_rounded),
                onPressed: () => onRemove(tr.id),
              ),
        leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(child: Text('R\$${tr.value}')),
            )),
        title: Text(
          tr.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat('d MMM y').format(tr.date)),
      ),
    );
  }
}

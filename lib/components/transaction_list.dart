import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions, this.onRemove);
  final void Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(children: [
                Text(
                  "Nenhuma transação cadastrada",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ]);
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Transaction_item(onRemove: onRemove, tr: tr);
              // Card(
              //         child: Row(
              //           children: [
              //             SizedBox(
              //               width: 175,
              //               child: Container(
              //                 margin: EdgeInsets.symmetric(
              //                   horizontal: 15,
              //                   vertical: 10,
              //                 ),
              //                 padding: EdgeInsets.all(10),
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: Theme.of(context).colorScheme.primary,
              //                     width: 2,
              //                   )
              //                 ),
              //                 child:
              //                   Text(
              //                     'R\$  ${tr.value.toStringAsFixed(2).replaceAll('.', ',')}',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       fontWeight: FontWeight.bold,
              //                       fontSize: 20,
              //                       color: Theme.of(context).colorScheme.primary,
              //                     ),
              //                   ),
              //               ),
              //             ),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   tr.title,
              //                   style: Theme.of(context).textTheme.headline6,
              //                   ),
              //                 Text(DateFormat('d MMM y').format(tr.date),
              //                     style: TextStyle(
              //                       color: Colors.grey.shade600,
              //                   ))
              //               ],
              //             ),

              //           ],
              //         ),
              //       );
            },
          );
  }
}


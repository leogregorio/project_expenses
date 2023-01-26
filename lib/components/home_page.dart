import 'package:flutter/material.dart';
import 'chart.dart';
import '../models/transaction.dart';
import 'transaction_list.dart';
import 'transaction_form.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transaction(
        id: 't0',
        title: 'Conta Antiga',
        value: 6969,
        date: DateTime.now().subtract(Duration(days: 33))),
    Transaction(id: 't1', title: 'Tênis', value: 310.76, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Conta de Luz',
        value: 300.00,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: 't3',
        title: 'Conta de Agua',
        value: 100.00,
        date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(
        id: 't4',
        title: 'Conta de Gás',
        value: 0.00,
        date: DateTime.now().subtract(Duration(days: 8))),
  ];
  //final List<Transaction> _transactions = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        date: date,
        value: value);

    setState(() {
      _transactions.add(newTransaction);
    });

    //fechar modal
    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => (element.id == id));
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryOfContext = MediaQuery.of(context);
    bool isLandscape =
       mediaQueryOfContext.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Despesas Pessoais'),
      actions: <Widget>[
        if(isLandscape)
        IconButton(
          icon: Icon(_showChart ? Icons.list : Icons.show_chart),
          onPressed: () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
        IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add)),
      ],
      backgroundColor: Theme.of(context).colorScheme.primary,
    );

    final availableHeight = mediaQueryOfContext.size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              // if (isLandscape)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Exibir gráfico'),
              //       Switch.adaptative(                         
              //           value: _showChart,
              //           onChanged: (value) {
              //             setState(() {
              //               _showChart = value;
              //             });
              //           }),
              //     ],
              //   ),
              if (_showChart || !isLandscape)
                Container(
                    height: availableHeight * (isLandscape ? 0.7 : 0.3),
                    child: Chart(
                      _recentTransactions,
                    )),
              if (!_showChart || !isLandscape)
                Container(
                  height: availableHeight * (isLandscape ? 1.0 : 0.7),
                  child: TransactionList(_transactions, _deleteTransaction),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String weekDay;
  final double value;   
  final double total;
  
  ChartBar(this.weekDay, this.total, this.value);
  

  @override
  Widget build(BuildContext context) {
    double percentage = 0.0;
    if(total > 0.0)
     percentage = value*100.0 / total;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
        child: Column(
          children:<Widget> [
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  'R\$${this.value.toStringAsFixed(2).replaceAll('.', ',')}', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox( width: 10, height: constraints.maxHeight * 0.6,
              child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, 
                          width: 1.0 ),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: percentage/100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    )
                  ],
                )
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(weekDay)),
            ),
          ],
        ),
      );
      },  
    );
  }
}
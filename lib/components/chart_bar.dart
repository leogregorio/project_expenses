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
    return Container(
      child: Column(
        children:<Widget> [
          Container(
            height: 20,
            child: FittedBox(
              child: Text(
                'R\$  ${this.value.toStringAsFixed(2).replaceAll('.', ',')}', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          SizedBox( width: 10, height: 60,
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
            child: Text(weekDay),
          ),
        ],
      ),
    );
  }
}
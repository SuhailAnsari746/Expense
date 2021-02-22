import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyChartBar extends StatelessWidget {
  final spendingAmount;
  final sdays;
  final perAmount;
  MyChartBar({this.spendingAmount, this.sdays, this.perAmount});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:(ctx,constraints){
           return  Column(
      children: <Widget>[
        Container(
          height: constraints.maxHeight*0.15,
          child: FittedBox(
                    child: Text(
              '\$${spendingAmount.toStringAsFixed(0)}',
                    )
          ),
        ),
        SizedBox(
          height: constraints.maxHeight*0.05,
        ),
        //Padding(padding: EdgeInsets.all(10),),
        Container(
          height: constraints.maxHeight*0.6,
          width: 12,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: perAmount,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight*0.05,
        ),
        Container(
          height:constraints.maxHeight*0.15,
          child: Text(sdays)),
      ],
    );
    }); 
  }
}

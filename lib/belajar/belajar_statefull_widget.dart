import 'package:flutter/material.dart';

class BelajarStatefullWidget extends StatefulWidget {
  const BelajarStatefullWidget({super.key});

  @override
  State<BelajarStatefullWidget> createState() => _BelajarStatefullWidgetState();
}

class _BelajarStatefullWidgetState extends State<BelajarStatefullWidget> {
  int _counter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$_counter', style: TextStyle(fontSize: (20 + _counter.toDouble())),),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_counter > 1) {
                        _counter--; 
                      }
                    });
                  },
                  child: Container(
                    child: Icon(Icons.remove),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _counter++;
                    });
                  },
                  child: Container(
                    child: Icon(Icons.add),
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
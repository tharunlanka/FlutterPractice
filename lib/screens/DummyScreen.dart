import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dummy.dart';

class DummyScreen extends StatelessWidget {
  const DummyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DummyDataClass(),
      child: Consumer<DummyDataClass>(
        builder: (context, cart, child) {
          return Column(children: [
            Text('X Value is : ${cart.X}'),
            ElevatedButton(onPressed:()=>{
              cart.incrementX()
            } , child:const Text("Click Here")),
          ],);
        },
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/utilities/ElevatedButtonWidget.dart';

class AddListScreen extends StatelessWidget {
  const AddListScreen({super.key});

  // void _showModalBottomSheet(context){
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext bc){
  //       return Wrap(
  //           children: <Widget>[
  //       ListTile(
  //       leading:  const Icon(Icons.offline_bolt),
  //       title:  const Text('Old'),
  //       onTap: () => {
  //       }
  //       ),
  //       ListTile(
  //       leading: const Icon(Icons.book_online),
  //       title: const Text('New'),
  //       onTap: () => {
  //     },
  //   ),
  //   ],
  //   );
  // }
  // );}


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(15),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
              hintText: 'Enter Title',
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Amount',
              hintText: 'Enter Amount',
            ),
          ),
        ),
        ElevatedButtonWidget(
          textData: 'Add',
          onPressed: () {
           // _showModalBottomSheet(context)

            ;
          },
        )
      ],
    );
  }
}

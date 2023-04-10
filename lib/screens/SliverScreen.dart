import 'package:flutter/material.dart';


class SliverScreen extends StatelessWidget {
  const SliverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sliver Screen'),
          elevation: 0,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(actions: <Widget>[
              Icon(
                Icons.add_circle,
                size: 40,
              )
            ],
                title: Text("SliverGrid"), leading: Icon(Icons.menu), backgroundColor: Colors.green, expandedHeight: 100.0, floating: true, pinned: true),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(color: _randomPaint(index), height: 100.0, child: Text(index.toString()));
              }),
            ),
          ],
        ),
      ),
    );
  }
}


Color _randomPaint(int index) {
  if (index % 3 == 0) {
    return Colors.yellowAccent;
  } else if (index % 3 == 1) {
    return Colors.orange;
  }
  return Colors.red;
}
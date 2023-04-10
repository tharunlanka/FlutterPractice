import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/ListFromApiScreen.dart';
import 'package:flutter_practice/screens/ProductScreen.dart';
import 'AnimationScreen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('More Screen'),
          backgroundColor: Colors.blue,
          bottom: TabBar(
            controller: _controller,
            tabs: const [
              Tab(icon: Icon(Icons.message), text: 'Chats'),
              Tab(icon: Icon(Icons.animation), text: 'Animation'),
              Tab(icon: Icon(Icons.shopping_cart_outlined), text: 'Products')
            ],
          )),
      body:
      TabBarView(
        controller: _controller,
        children: const <Widget>[
          ListFromApiScreen(),
          AnimationScreen(),
          ProductScreen(),
        ],
      ),
    );
  }
}

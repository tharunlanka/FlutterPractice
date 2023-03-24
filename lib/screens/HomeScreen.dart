import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  void moveToProfileScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text("Home Screen"),
          ),
          body: const Center(child: Text("Home Screen Content")),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              moveToProfileScreen();
            },
            child: const Icon(Icons.navigate_next),
          ),
        ));
  }
}

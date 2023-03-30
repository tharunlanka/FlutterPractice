import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_practice/screens/AddTransactionScreen.dart';
import 'package:flutter_practice/screens/HomeScreen.dart';
import 'package:flutter_practice/screens/ProfileScreen.dart';

void main() {
  // to set the orientation in portrait only
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void moveToProfileScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final pageBody = [
      const HomeScreen(),
      const AddTransactionScreen(),
      const ProfileScreen(),
    ].elementAt(_selectedIndex);

    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(widget.title),
            leading: CupertinoButton(
              child: const Icon(CupertinoIcons.bars),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
            ),

          )
        : PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => {scaffoldKey.currentState?.openDrawer()},
              ),
              title: Text(
                widget.title,
              ),
            ));

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/img.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: Text(
                  'Select Tech',
                ),
              ),
            ),
            ListTile(
              title: const Text('Flutter'),
              onTap: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              leading: const Icon(Icons.flutter_dash),
              trailing: const Icon(Icons.navigate_next_outlined),
            ),
            ListTile(
              title: const Text('Android'),
              onTap: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              leading: const Icon(Icons.android),
              trailing: const Icon(Icons.navigate_next_outlined),
            ),
            ListTile(
              title: const Text('Ios'),
              onTap: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              leading: const Icon(Icons.apple),
              trailing: const Icon(Icons.navigate_next_outlined),
            )
          ],
        ),
      ),
      body: pageBody,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Colors.white : Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: _selectedIndex == 1 ? Colors.white : Colors.black,
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              color: _selectedIndex == 2 ? Colors.white : Colors.black,
            ),
            label: 'Profile',
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
      ),
    );
  }
}

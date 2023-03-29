import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/AddListScreen.dart';
import 'package:flutter_practice/screens/HomeScreen.dart';
import 'package:flutter_practice/screens/ProfileScreen.dart';

void main() {
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

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Fab Clicked',style: TextStyle(fontFamily: 'Roboto'),),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  final screens = [
    const HomeScreen(),
    const AddListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
        title: Text(widget.title,),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/img.png"),
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
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      // floating button hide
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => CallBackFunction(
      //               text: "Clicked", onPressed: () => _showToast(context)))),
      //   child: const Icon(Icons.navigate_next),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
      ),
    );
  }
}

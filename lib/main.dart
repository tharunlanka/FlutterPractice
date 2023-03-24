import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/HomeScreen.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String _contentName = "Home";
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _contentName = index == 0 ? "Home" : (index == 1 ? "Cart" : "Profile");
      _selectedIndex = index;
    });
  }

  void _changeText(String name) {
    setState(() {
      _contentName = name;
      scaffoldKey.currentState?.openEndDrawer();
    });
  }

  void moveToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
        title: Text(widget.title),
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
                _changeText("Flutter");
              },
              leading: const Icon(Icons.flutter_dash),
              trailing: const Icon(Icons.navigate_next_outlined),
            ),
            ListTile(
              title: const Text('Android'),
              onTap: () {
                _changeText("Android");
              },
              leading: const Icon(Icons.android),
              trailing: const Icon(Icons.navigate_next_outlined),
            ),
            ListTile(
              title: const Text('Ios'),
              onTap: () {
                _changeText("Ios");
              },
              leading: const Icon(Icons.apple),
              trailing: const Icon(Icons.navigate_next_outlined),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _contentName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis),
              maxLines: 2,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: moveToNextScreen,
        child: const Icon(Icons.navigate_next),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.white,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart,color: Colors.white,),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people,color: Colors.white,),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

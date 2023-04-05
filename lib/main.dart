import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practice/providers/cart.dart';
import 'package:flutter_practice/providers/products.dart';
import 'package:flutter_practice/routes/Routes.dart';
import 'package:flutter_practice/screens/AddTransactionScreen.dart';
import 'package:flutter_practice/screens/HomeScreen.dart';
import 'package:flutter_practice/screens/ProfileScreen.dart';
import 'package:flutter_practice/routes/Router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Products(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Practice',
            // adding routes to app,
            onGenerateRoute: AppRouter().generateRoute,
            theme: ThemeData(
              // UI
              // font
              fontFamily: 'Roboto',
              //text style
              textTheme: const TextTheme(
                displayLarge:
                    TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                titleLarge:
                    TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
              ),
            )));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogged = false;

  void nextScreen() {
    if (isLogged) {
      Navigator.pushNamed(context, homeRoute);
    } else {
      Navigator.pushNamed(context, loginRoute);
    }
  }

  getAllSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool('isLogged');
    if (value != null) isLogged = value;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllSavedData();
    Timer(const Duration(seconds: 4), () => nextScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image(
          image: AssetImage('assets/images/splash.png'),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),);
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
    if (index == 3) {
      Navigator.pushNamed(context, moreRoute);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void moveToProfileScreen() {
    Navigator.pushNamed(context, profileRoute);
  }

  @override
  Widget build(BuildContext context) {
    final pageBody = [
      const HomeScreen(),
      const AddTransactionScreen(),
      const ProfileScreen(),
    ].elementAt(_selectedIndex);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => {scaffoldKey.currentState?.openDrawer()},
          ),
          title: Text(
            widget.title,
          ),
        ),
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
                color: _selectedIndex == 0 ? Colors.blue : Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: _selectedIndex == 1 ? Colors.blue : Colors.black,
              ),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: _selectedIndex == 2 ? Colors.blue : Colors.black,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more_vert,
                color: _selectedIndex == 3 ? Colors.blue : Colors.black,
              ),
              label: 'More',
            ),
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
        ),
      ),
    );
  }
}

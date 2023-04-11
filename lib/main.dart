import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice/providers/cart.dart';
import 'package:flutter_practice/providers/products.dart';
import 'package:flutter_practice/routes/Routes.dart';
import 'package:flutter_practice/screens/AddTransactionScreen.dart';
import 'package:flutter_practice/screens/DisplayPictureScreen.dart';
import 'package:flutter_practice/screens/HomeScreen.dart';
import 'package:flutter_practice/screens/ProfileScreen.dart';
import 'package:flutter_practice/routes/Router.dart';
import 'package:flutter_practice/widgets/LocationScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';


List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      // Initialize FlutterFire
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Error While Initializing the firebase ",
              textDirection: TextDirection.ltr,
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
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
                      displayLarge: TextStyle(
                          fontSize: 72.0, fontWeight: FontWeight.bold),
                      titleLarge: TextStyle(
                          fontSize: 36.0, fontStyle: FontStyle.italic),
                      bodyMedium:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
                    ),
                  )));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
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
      Navigator.popAndPushNamed(context, homeRoute);
    } else {
      Navigator.popAndPushNamed(context, loginRoute);
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
      ),
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
  bool isPhotoUploaded = false;
  File? image;
  File _image=File('');
  final picker = ImagePicker();

  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.pushNamed(context, moreRoute);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHeaderData();
  }

  void moveToProfileScreen() {
    Navigator.pushNamed(context, profileRoute);
  }

  saveImageUploadValueInSharedPref(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isHeaderUploaded', true);
    prefs.setString('imagePath', path);
  }

  getHeaderData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool('isHeaderUploaded');
    String? imagePath = prefs.getString('imagePath');
    if (value != null) isPhotoUploaded = value;
    if (imagePath != null) image = File(imagePath);
    setState(() {});
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() => {
            this.image = File(image.path),
            isPhotoUploaded = true,
            saveImageUploadValueInSharedPref(image.path)
          });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }


  // get image from default camera
  Future<void> _getImage() async {
    print("clicked");
    final PickedFile? pickedImage = await picker.getImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    File tmpFile = File(pickedImage.path);
    tmpFile = await tmpFile.copy(tmpFile.path);
    setState(() {
      _image = File(pickedImage.path);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DisplayPictureScreen(image: _image)));
    });
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
              !isPhotoUploaded
                  ? DrawerHeader(
                      child: ElevatedButton(
                        onPressed: () => {pickImage()},
                        child: const Text("Pick Image from Gallery"),
                      ),
                    )
                  : DrawerHeader(
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
              ListTile(
                title: const Text('Camera'),
                onTap: () async {
                   await _getImage();
                  scaffoldKey.currentState?.openEndDrawer();
                },
                leading: const Icon(Icons.camera),
                trailing: const Icon(Icons.navigate_next_outlined),
              ),
              ListTile(
                title: const Text('Location'),
                onTap: () async {
                  scaffoldKey.currentState?.openEndDrawer();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LocationScreen()));
                },
                leading: const Icon(Icons.add_location_sharp),
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

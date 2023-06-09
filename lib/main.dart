import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice/models/cart.dart';
import 'package:flutter_practice/models/products.dart';
import 'package:flutter_practice/providers/auth/AuthProvider.dart';
import 'package:flutter_practice/routes/Routes.dart';
import 'package:flutter_practice/screens/AddTransactionScreen.dart';
import 'package:flutter_practice/screens/DisplayPictureScreen.dart';
import 'package:flutter_practice/screens/HomeScreen.dart';
import 'package:flutter_practice/screens/ProfileScreen.dart';
import 'package:flutter_practice/routes/Router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adapter/PeopleAdapter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'notifications/PushNotificationService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  await PushNotificationService().setupInteractedMessage();
  await Hive.initFlutter(document.path);
  await Hive.openBox('peopleBox');
  Hive.registerAdapter(PeopleAdapter());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(MyApp(
    prefs: prefs,
  ));

  // RemoteMessage? initialMessage =
  //     await FirebaseMessaging.instance.getInitialMessage();

  // onMessage is called when the app is in foreground and a notification is received
  FirebaseMessaging.onMessage.listen((RemoteMessage? message) {

    final RemoteNotification? notification = message!.notification;
    final AndroidNotification? android = message.notification?.android;
// If `onMessage` is triggered with a notification
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
     var data=message.data[0]['name'];
     Fluttertoast.showToast(msg: data);
    }
  });
  //
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
    final RemoteNotification? notification = message!.notification;
    final AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      Fluttertoast.showToast(msg: notification.title!);
    }
  },);

  await Permission.notification.isDenied.then(
    (bool value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
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
                ChangeNotifierProvider<AuthProvider>(
                    create: (_) => AuthProvider(
                        firebaseFirestore: firebaseFirestore,
                        prefs: prefs,
                        googleSignIn: GoogleSignIn(),
                        firebaseAuth: FirebaseAuth.instance)),
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
  Future<void> nextScreen() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var isLogged = await authProvider.isLoggedIn();
    if (isLogged && context.mounted) {
      Navigator.popAndPushNamed(context, homeRoute);
    } else {
      Navigator.popAndPushNamed(context, loginRoute);
    }
  }

  @override
  void initState() {
    super.initState();
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
  File _image = File('');
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
    final PickedFile? pickedImage =
        await picker.getImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    File tmpFile = File(pickedImage.path);
    tmpFile = await tmpFile.copy(tmpFile.path);
    setState(() {
      _image = File(pickedImage.path);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(image: _image)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
                  Navigator.pushNamed(context, location);
                },
                leading: const Icon(Icons.add_location_sharp),
                trailing: const Icon(Icons.navigate_next_outlined),
              ),
              ListTile(
                title: const Text('Hive Storage'),
                onTap: () async {
                  scaffoldKey.currentState?.openEndDrawer();
                  Navigator.pushNamed(context, addPerson);
                },
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.navigate_next_outlined),
              ),
              ListTile(
                title: const Text('Chats'),
                onTap: () async {
                  scaffoldKey.currentState?.openEndDrawer();
                  Navigator.pushNamed(context, chats);
                },
                leading: const Icon(Icons.message),
                trailing: const Icon(Icons.navigate_next_outlined),
              ),

              ListTile(
                title: const Text('Battery'),
                onTap: () async {
                  scaffoldKey.currentState?.openEndDrawer();
                  Navigator.pushNamed(context, battery);
                },
                leading: const Icon(Icons.battery_6_bar_sharp),
                trailing: const Icon(Icons.navigate_next_outlined),
              ),
              ListTile(
                title: const Text('Log Out'),
                onTap: () async {
                  scaffoldKey.currentState?.openEndDrawer();
                  bool isLoggedOut = await authProvider.googleSignOut();
                  if (isLoggedOut && context.mounted) {
                    Navigator.pushNamed(context, loginRoute);
                  }
                },
                leading: const Icon(Icons.logout_outlined),
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

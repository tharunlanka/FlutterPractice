import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/models/request/Authentication.dart';
import 'package:flutter_practice/utilities/fieldValidator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/AuthProvider.dart';
import '../routes/Routes.dart';
import 'package:firebase_database/firebase_database.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  {
  final _formKey = GlobalKey<FormState>();
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  saveLoggedValueInSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', true);
  }


  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'Sign in failed');
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'Sign in cancelled');
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Sign in successful');
        break;
      default:
        break;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:Form(
        key: _formKey,
          child:Column(
          children: <Widget>[
           const Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: FlutterLogo()),
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: emailInput,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email'),
                validator: (email) {
                  if (Validator.validateEmail(email!) == null) {
                    return null;
                  } else {
                    return 'Enter a valid email address';
                  }
                },
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: passwordInput,
                obscureText: true,
                maxLength: 8,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
                validator: (password) {
                  if (Validator.validatePassword(password!)==null) {
                    return null;
                  } else {
                    return 'Enter a valid password';
                  }
                },
              ),
            ),
            TextButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      DatabaseReference ref = FirebaseDatabase.instance.ref("users");
                     ref.once().then((value) => {
                       value.snapshot.children.forEach((user) {
                         final data = Map<String, dynamic>.from(user.value as Map);
                         LoginRequest request = LoginRequest.fromJson(data);
                         if(emailInput.text==request.email.toString() && passwordInput.text==request.password.toString()){
                           saveLoggedValueInSharedPref();
                           Navigator.pop(context,true);
                           Navigator.pushNamed(context, homeRoute);
                         }
                         else{
                           const Center(child: Text('Unable To Login',textDirection: TextDirection.ltr,));
                         }
                       })
                     });

                      // DataSnapshot


                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),

            GestureDetector(
              onTap: () async {
                bool isSuccess = await authProvider.handleGoogleSignIn();
                if (isSuccess) {
                  Navigator.pushNamed(context, homeRoute);
                }
              },
              child: Image.asset('assets/images/google_sign_in.png'),
            ),
            const SizedBox(
              height: 130,
            ),
            TextButton(
              onPressed: (){
                Navigator.popAndPushNamed(context, registerRoute);
              },
              child: const Text('New User? Create Account',)
            ),
          ],
        ),
      ),
      ),
    );
  }
}
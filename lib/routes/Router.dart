import 'package:flutter/material.dart';
import 'package:flutter_practice/main.dart';
import 'package:flutter_practice/screens/AddTransactionScreen.dart';
import 'package:flutter_practice/screens/LoginScreen.dart';
import 'package:flutter_practice/screens/MoreScreen.dart';
import 'package:flutter_practice/screens/ProductScreen.dart';
import 'package:flutter_practice/screens/ProfileScreen.dart';
import 'package:flutter_practice/routes/Routes.dart';
import 'package:flutter_practice/screens/cart_screen.dart';
import 'package:flutter_practice/screens/products_overview_screen.dart';
import '../models/ScreenArguments.dart';
import '../screens/UserDetailsScreen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(title: 'Flutter'));
      case addRoute:
        return MaterialPageRoute(builder: (_) => const AddTransactionScreen());
        case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case moreRoute:
        return MaterialPageRoute(builder: (_) => const MoreScreen());
      case cartRoute:
        return MaterialPageRoute(builder: (_) =>  CartScreen());
      case productOverview:
        return MaterialPageRoute(builder: (_) => const ProductsOverviewScreen());
      case product:
        return MaterialPageRoute(builder: (_) => const ProductScreen());
      case userDetails:
        {
          final args = settings.arguments as ScreenArguments;
          return MaterialPageRoute(
              builder: (_) =>
                  UserDetailsScreen(title: args.title, image: args.image));
        }
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}



import 'package:flutter/material.dart';
import 'package:jartech_app/screens/auth/login.dart';
import 'package:jartech_app/screens/auth/register.dart';
import 'package:jartech_app/screens/delivery/delivery_screen.dart';
import 'package:jartech_app/screens/splash/splash_screen.dart';

import '../screens/cart/cart.dart';
import '../screens/service/service.dart';
import '../screens/service/service_detail.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/home-screen':
        return MaterialPageRoute(builder: (_) => const Service());       
         case '/ecran-panier':
        return MaterialPageRoute(builder: (_) =>  CartScreen());          
          case '/login-screen':
        return MaterialPageRoute(builder: (_) =>  const LoginScreen());           
            case '/sing-up-screen':
        return MaterialPageRoute(builder: (_) =>  const RegisterScreen()); 

          case '/livraison':
        return MaterialPageRoute(builder: (_) =>  const DeliveryScreen()); 
          case '/detail-service':
        ServiceDetail argument = args as ServiceDetail;
        return MaterialPageRoute(
            builder: (_) => ServiceDetail(pack: argument.pack,));
      default:
        // If there is no such named route in the switch statement, e.g. /HomeScreen
        return _errorRoute();
    }
  }

  //

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

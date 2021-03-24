import 'package:flutter/material.dart';
import 'package:sigascript/rootPage.dart';
import 'package:sigascript/routemanager.dart';
import 'package:sigascript/services/emailValidator.dart';
import 'services/auth.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                RootPage(auth: new Auth(), validator: new Validator()));
      case '/login':
        // Validation of correct data type
        return MaterialPageRoute(builder: (_) => RouteManager());
      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

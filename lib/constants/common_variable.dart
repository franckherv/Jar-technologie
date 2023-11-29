import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class NetworkVariable {

  //? API BASE URL
  static const apiBaseUrl = "https://api.winihost.com/"; 

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get globalContext => navigatorKey.currentState!.overlay!.context;

  //? date and hour management variable
  static final ddMMYYFormat = DateFormat('dd-MM-yyyy');
  static final formattedDate = DateFormat('kk:mm:ss EEE d MMM');
  static final hhMMFormat = DateFormat('h:m');
}

// ignore_for_file: depend_on_referenced_packages

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jartech_app/models/preferences.dart';
import 'package:jartech_app/router/route_generator.dart';
import 'package:provider/provider.dart';
import 'constants/app_colors.dart';
import 'screens/splash/splash_screen.dart';
import 'state_manager/global_state_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Box? box1;

void main() async {
  await Hive.initFlutter();
  box1 = await Hive.openBox('logindata');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (__) => GlobalStateManager(),
            ),
          ],
          child: MaterialApp(
              title: 'jartech_app',
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('fr', 'FR'),
              ],
              localizationsDelegates: const [
                CountryLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: AppColors.appMaterialColor,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              onGenerateRoute: RouteGenerator.generateRoute,
              home: SplashScreen(
                initialFutures: [
                  SharedPrefs.init(),
                ],
              )),
        );
      },
    );
  }
}

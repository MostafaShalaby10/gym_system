// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/components/components.dart';
import 'package:gym_system/cubit/cubit.dart';
import 'package:gym_system/cubit/states.dart';
import 'package:gym_system/pages/admin/adminHomePage.dart';
import 'package:gym_system/pages/authentication/login.dart';
import 'package:gym_system/pages/user/homePage.dart';

import 'sharedPrefrences/sharedPrefrences.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black, statusBarIconBrightness: Brightness.light));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefs.init();
  
  if (SharedPrefs.getData(key: "admin") == null) {
    if (SharedPrefs.getData(key: "user") == null) {
      runApp(const MyApp(
        start: Login(),
      ));
    } else {
        runApp(const MyApp(
          start: HomePage(),
        ));

    }
  } else {
    runApp(const MyApp(
      start: AdminHomePage(),
    ));
  }
}

class MyApp extends StatelessWidget {
  final Widget start;

  const MyApp({super.key, required this.start});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit, States>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Gemy',
              theme: ThemeData(
                textTheme: const TextTheme(
                  bodyMedium: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 15
                  )
                ),

                primaryColor: Colors.white,
                  inputDecorationTheme: InputDecorationTheme(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: const BorderSide(width: 0)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)))),
              home: start,
            );
          },
          listener: (context, state) {}),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hipoclientapp/screens/client-list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hipo Project',
      //This is design part of the project we can change shape and color of all elements from themedata
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            elevation: 10,
            backgroundColor: Colors.green,
            padding: const EdgeInsets.all(12.0),
          )
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.black,),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.black,),
          ),
          filled: true,
          prefixIconColor: Colors.black,
        ),
      ),
      
      home: const clientListPage(),
    );
  }
}

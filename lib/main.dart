
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/page/pages.dart';

import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/providers/scans_list_provider.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  final Color color= Colors.teal;
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
         ChangeNotifierProvider(create: (_) => new ScanListProvider()),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'Qr-Reader',
        initialRoute: 'home',
       routes: {
          'home' : (_) =>  HomePage(),
          'mapa' : (_) =>  MapaPage(),
       },
       theme: ThemeData(
        
        primaryColor: color,
        bottomNavigationBarTheme:  BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(color: color)),
        appBarTheme:  AppBarTheme(backgroundColor: color),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor:color, 
          ) 
        )
    
      ),
    );
  }
}
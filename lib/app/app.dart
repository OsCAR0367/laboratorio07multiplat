import 'package:flutter/material.dart';
import 'package:laboratorio04/app/view/splash/splash_page.dart';
import 'package:laboratorio04/app/view/task_list/task_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF40B7AD);
    const textColor = Color.fromARGB(255, 254, 254, 254);
    const backgroundColor = Color.fromARGB(255, 150, 40, 40);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: backgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Poppins',
              bodyColor: textColor,
              displayColor: textColor,
            ),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}

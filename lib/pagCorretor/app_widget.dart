import 'package:flutter/material.dart';
import 'package:projetopi/pagCorretor/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => CorretorHomePage(),
      },
    );
  }
}
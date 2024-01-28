import 'package:flutter/material.dart';
import 'package:internship_search_app/screens/search_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SearchPage()),
      );
    });

   
    return Scaffold(
      body: Center(
        child: Image.network(
            'https://internshala.com/static/images/internshala_og_image.jpg'),
      ),
    );
  }
}

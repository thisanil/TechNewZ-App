import 'package:entry/entry.dart';
import 'package:flutter/material.dart';

import 'new_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NewScreen()));

    });
  }



  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0B0019),
      body: Center(
        child: Entry.scale(
            duration: Duration(milliseconds: 1500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                    TextSpan(text:"Tech",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.yellow),
                        children: [
                          TextSpan(text:"NewZ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.white),)
                        ]
                    )),
              ],
            )),
      ),
    );
  }
}

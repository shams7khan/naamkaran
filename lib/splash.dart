import 'package:app_naamkaran/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateTo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Image.asset("assets/latest.png",
          // fit: BoxFit.fill,
        ),
      ),
      
    );
  }

  navigateTo()async{
    await Future.delayed(Duration(milliseconds: 3000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage() ));
  }
}
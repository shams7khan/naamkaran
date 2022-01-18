import 'package:app_naamkaran/boy.dart';
import 'package:app_naamkaran/girl_update.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset("assets/home/background.png",
                fit: BoxFit.fill,
              )
            ),
            Column(
              children: [
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset("assets/home/logo.png"),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector( 
                      onTap: (){
                        Get.to(GirlUpdate());
                      },
                      child: Image.asset("assets/home/girl.png",
                       width: (MediaQuery.of(context).size.width - 10)/2,
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: (){
                        Get.to(BoyClass());
                      },  
                      child: Image.asset("assets/home/boy.png",
                       width: (MediaQuery.of(context).size.width - 10)/2,
                      ),
                    )
                  ],
                ),

                SizedBox(height: 30),

                Image.asset("assets/home/fav.png",
                  width: MediaQuery.of(context).size.width/2,
                  height: 80,
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
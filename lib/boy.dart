import 'dart:convert';
import 'package:app_naamkaran/model/category.dart';
import 'package:app_naamkaran/model/name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:expandable_text/expandable_text.dart';

class BoyClass extends StatefulWidget {
  const BoyClass({ Key? key }) : super(key: key);

  @override
  _BoyClassState createState() => _BoyClassState();
}

class _BoyClassState extends State<BoyClass> {

  List<Example> catArr = [];
  List<Name> nameArr = [];

  @override
  void initState() {
    super.initState();
    religionCategory();
    nameApi("3", 1);
  }


  @override
  Widget build(BuildContext context) {
    if (catArr.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return Stack(
      children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset("assets/boy_background.png",
                fit: BoxFit.fill,
              ),
          ),

        DefaultTabController(
          length: catArr.length,
          // final tabindex = DefaultTabController.of(context)!.index;

          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Image.asset("assets/header/header_back@2x.png", width: 35, height: 35,)
                ),
                Image.asset("assets/header/header_logo@2x.png", width: 150,),
                Image.asset("assets/header/header_girl@2x.png", width: 50, height: 50,),
                Image.asset("assets/header/header_fav@2x.png", width: 35, height: 35,),
                GestureDetector(
                  onTap: (){
                    // showSearch(context: context, delegate: MyCustemSearch())
                  },
                  child: Image.asset("assets/header/header_search@2x.png", width: 35, height: 35,)
                ),
                ],
              ),
              automaticallyImplyLeading: false,
              bottom: TabBar(
                        onTap: (index){
                          // setState(() {
                          //   isLoading = true;
                          // });
                          switch (index) {
                            case 0: nameApi("3", 1);
                            // catId = "3";
                            // genderNo = 1;
                            // isLoading = true;
                            // print(isLoading);
                            break;
                              
                            case 1: nameApi("8", 1);
                            // catId = "8";
                            // genderNo = 1;
                            // isLoading = true;
                            break;

                            case 2: nameApi("10", 1);
                            // catId = "10";
                            // genderNo = 1;
                            // isLoading = true;
                            break;
                          }
                        },
                        // controller: TabController,
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        labelColor: Colors.black,
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: "Lora",
                          fontWeight: FontWeight.bold
                        ),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),

                     
                        tabs: List.generate(catArr.length,(index) {
                          return Tab(text: catArr[index].catName);
                        }),

                        
                      ),
            ),

           
            body: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: TabBarView(
                children: [
                 
                  bodyNameList(),
                  
                  bodyNameList(),
                  
                  bodyNameList(),
                                
                ]
              ),
            ),
          )
        ),
      ],
    );
  }

  religionCategory()async{
    var resp = await http.get(Uri.parse("http://mapi.trycatchtech.com/v1/naamkaran/category_list"));
    var jsonResp = json.decode(resp.body);
    for (var item in jsonResp) {
      catArr.add(Example.fromJson(item));
    }
    setState(() {
      
    });    
  }

  // nameApi(String catId,int gendeNo){
  //   http
  //     .get(Uri.parse("https://mapi.trycatchtech.com/v1/naamkaran/post_list_by_cat_and_gender?category_id=$catId&gender=$gendeNo"))
  //     .then((resp) {
  //       nameArr.clear();
  //       var jsonResp = json.decode(resp.body);
  //       for (var item in jsonResp) {
  //         nameArr.add(Name.fromJson(item)); 
  //       }
  //     });
  // }

  nameApi(String catId,int genderNo)async{
    nameArr.clear();
    var resp = await http.get(Uri.parse("https://mapi.trycatchtech.com/v1/naamkaran/post_list_by_cat_and_gender?category_id=$catId&gender=$genderNo"));
    var jsonResp = json.decode(resp.body);
    for (var item in jsonResp) {
      nameArr.add(Name.fromJson(item)); 
    }
    // // print("hello");
    // if (nameArr.isNotEmpty) {
    //   setState(() {
    //     print(nameArr.length);
    //   });
    // }
    // return nameArr;
    setState(() {
      // isLoading = false;
    });
  }

  Widget bodyNameList(){
    // nameApi(catId, genderNo);
    // print("hello");
    // print(0)
    // print("$catId and $genderNo");
    // print(nameArr.length);
    // if (nameArr.isEmpty) {
    //   return CircularProgressIndicator();
    // }
   
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), 
      ),
    
      child: nameArr.length == 0 ?  const Center(child: CircularProgressIndicator()) : ListView.separated(
        itemBuilder: (context,index){
          // isLoading = true;
          // print(isLoading);
          return Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nameArr[index].name!,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Lora" 
                                ),
                              ),
                                                            
                              ExpandableText(                          
                                nameArr[index].meaning!, 
                                maxLines: 2,
                                expandText: "Show more",
                                collapseText: "Show less",
                                style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Lora" 
                              ),
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 8,),

                      Row(                              
                        children: [
                          Image.asset("assets/blue_heart@2x.png", 
                            width: 35, 
                            height: 35, 
                          ),
                      
                          SizedBox(width: 8,),

                          Image.asset("assets/blue_copy@2x.png", 
                            width: 35, 
                            height: 35, 
                          ),

                          SizedBox(width: 8,),
                        
                          Image.asset("assets/blue_share@2x.png", 
                            width: 35, 
                            height: 35, 
                          ),
                        ],
                      )
                    ],
                  ),
            ),
          );
        }, 
        separatorBuilder: (context,index){
          return Divider();
        }, 
        itemCount: nameArr.length
      ),
    );
  }

  // Widget bodyNameList(){
  //   return FutureBuilder(
  //     future: nameApi(catId!, genderNo!),
  //     builder: (BuildContext context, AsyncSnapshot snapshot){
  //       print(snapshot.resp);
  //       return Container();
  //     }
  //   );
  // }
}

  
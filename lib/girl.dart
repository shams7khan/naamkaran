import 'dart:convert';
import 'package:app_naamkaran/boy.dart';
import 'package:app_naamkaran/model/category.dart';
import 'package:app_naamkaran/model/name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:expandable_text/expandable_text.dart';


class GirlClass extends StatefulWidget {
  const GirlClass({ Key? key }) : super(key: key);

  @override
  _GirlClassState createState() => _GirlClassState();
}

class _GirlClassState extends State<GirlClass> with SingleTickerProviderStateMixin {

  List<Example> catArr = [];
  List<Name> nameArr = [];
  List<Name> nameArrForDisplay = [];
  bool isLoading = true;
  late TabController tabController;
  TextEditingController tec = TextEditingController();

  @override
  void initState() {
    super.initState();
    religionCategory();
    tabController = TabController(length: 3, vsync: this)..addListener(() {setState(() {
      if (tabController.index == 0) {
        nameApi("3", 2);
      } else if(tabController.index == 1){
        nameApi("8", 2);
      } else{
        nameApi("10", 2);
      }

    });});
    
  }


  @override
  Widget build(BuildContext context) {
    if(catArr.isEmpty){
      return Center(child: CircularProgressIndicator());
    }
    return Stack(
      children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset("assets/girlname_background.png",
                fit: BoxFit.fill,
              ),
          ),

        DefaultTabController(
          length: 3,
          child: isLoading == true ? Center(child: CircularProgressIndicator()) : Scaffold(
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
                GestureDetector(
                  child: Image.asset("assets/header/header_boy@2x.png", width: 50, height: 50,),
                  onTap: (){
                    Get.to(BoyClass());
                  },
                ),
                Image.asset("assets/header/header_fav@2x.png", width: 35, height: 35,),
                
                ],
              ),
              automaticallyImplyLeading: false,
              bottom: TabBar(
                        controller: tabController,
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
        
                     
                        tabs: catArr.map((e) {
                          return Tab(child: Text(e.catName.toString()),);
                        }).toList()
                        
                      ),
            ),
        
           
            body: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: TabBarView(
                controller: tabController,
                children: [
                 
                  bodyNameList(),
                  
                  bodyNameList(),
                  
                  bodyNameList(),
                                
                ]
              ),
            ),
          ),
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
    nameApi("3", 2);
  }

 

  nameApi(String catId,int genderNo)async{
    if (isLoading == true) {
      nameArr.clear();
      nameArrForDisplay.clear();
      var resp = await http.get(Uri.parse(
          "https://mapi.trycatchtech.com/v1/naamkaran/post_list_by_cat_and_gender?category_id=$catId&gender=$genderNo"));
      var jsonResp = json.decode(resp.body);
      for (var item in jsonResp) {
        nameArr.add(Name.fromJson(item));
      }
   
      setState(() {
        isLoading = false;
        nameArrForDisplay = nameArr;
      });
    } else {
      setState(() {
        isLoading = true;
      });
      nameApi(catId, genderNo);
    }    
  }

  Widget bodyNameList(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), 
      ),
    
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context,index){
                print(nameArr[index].name);
                return index == 0 ? searchBar() : listItem(index - 1);
              }, 
              separatorBuilder: (context,index){
                return Divider();
              }, 
              itemCount: nameArrForDisplay.length + 1
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar(){
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search .. ",
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10)
        ),
        onChanged: (text){
            text = text.toLowerCase();
            setState(() {
             
              nameArrForDisplay = nameArr.where((tName) {
                var tNameTitle = tName.name!.toLowerCase();
                return tNameTitle.contains(text);
              }).toList();
            }); 
          } 
      ),
    );
  }

  Widget listItem(index){
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
                        Text(nameArrForDisplay[index].name!,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Lora" 
                          ),
                        ),
                                                      
                        ExpandableText(                          
                          nameArrForDisplay[index].meaning!, 
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
                      color: Colors.pink[300],
                      width: 35, 
                      height: 35, 
                    ),
                
                    SizedBox(width: 8,),

                    Image.asset("assets/blue_copy@2x.png",
                      color: Colors.pink[300], 
                      width: 35, 
                      height: 35, 
                    ),

                    SizedBox(width: 8,),
                  
                    Image.asset("assets/blue_share@2x.png",
                      color: Colors.pink[300], 
                      width: 35, 
                      height: 35, 
                    ),
                  ],
                )
              ],
            ),
      ),
    );
  }
}
  
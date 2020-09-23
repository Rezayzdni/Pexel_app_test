import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hindi_2/ui/pixelObject.dart';
import 'package:hindi_2/ui/searchPage.dart';
import 'package:hindi_2/ui/wallpaperPage.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin{
  TabController tabController;
  Widget _bottomNavAnimated;
  http.Response data;
  var decodedJson;
  bool hasInternet;
  bool isLoading;
  Map<String,String> authHeader = {
    "Authorization":"563492ad6f917000010000012a05cc0bd7be476ba7bd8db94e6d9573"
  };
  PixelObject pixelObject;
  int pageNumber;
  bool hasData;
  bool showSearch;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSearch = false;
    hasData = false;
    hasInternet = false;
    pageNumber = 0;
    isLoading = true;
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0
    );
    _bottomNavAnimated = bottomTabBars();
    /*
    tabController.addListener(() {
      print('what da ${tabController.index}');
      if(tabController.index == 1){
        //print('tttt');
        setState(() {
          _bottomNavAnimated = Padding(
            padding: EdgeInsets.all(5.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search between various of photos!"
              ),
            ),
          );
        });
      }
    });
     */

    fetchData("wallpaper",20);
  }
  incPageNumber(){
    pageNumber++;
  }
  bottomTabBars(){
    return TabBar(
      isScrollable: false,
      indicatorColor: Colors.amber,
      tabs: <Widget>[
        tab('Images', Icon(Icons.image,color: Colors.amber,)),tab('Search', Icon(Icons.search,color: Colors.amber,)),
      ],
      controller: tabController,
    );
  }
  Future<void> fetchData(String query , int perPage) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ) {
      //print('connected to mobile data or wifi');
      hasInternet = true;
      incPageNumber();
      try{
        data = await http.get("https://api.pexels.com/v1/search?query=$query&per_page=$perPage&page=$pageNumber",headers: authHeader);
      //  print('this is status code : ${data.statusCode}');
        decodedJson = json.decode(data.body);
        pixelObject = PixelObject.fromJson(decodedJson);
        if(pixelObject.totalResults != 0){
          hasData = true;
        }
      }
      on SocketException{
       // print("socket");
        hasInternet = false;
        //hasData = false;
      }
      catch(_){
        //print('catched');
        // hasData = false;
        hasInternet = false;
      }
    }
    else{
    //  print('no internet flow');
      hasInternet = false;
    }
    isLoading = false;
    setState(() {});
   // print(data.body);
    return null;
  }
  Widget card(String text){
    return Card(
      color: Colors.amber,
      child:Container(
        height: 200.0,
        width: 200.0,
        child: Center(child: Text(text)),
      ),
    );
  }
  Tab tab(String text,Icon icon){
    return Tab(
     // icon: icon,
      //text: text,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          icon,Text(text,style: TextStyle(fontWeight: FontWeight.w300,color: Colors.amber),)
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pixels App",style: TextStyle(
          fontWeight: FontWeight.w300 ,color: Colors.amber
        ),),
        brightness: Brightness.dark,
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(backgroundColor: Colors.amber,valueColor: AlwaysStoppedAnimation<Color>(Colors.black),)) :  nothingOrSth(),
      bottomNavigationBar: _bottomNavAnimated
    );
  }
  nothingOrSth(){
     if(!hasInternet){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("No Internet!",style:TextStyle(fontWeight: FontWeight.w300,color: Colors.amber,fontSize: 18.0)),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
            ),
            Icon(Icons.signal_wifi_off,color: Colors.amber,),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.amber
                ),
                child: MaterialButton(
                  child: Text('Retry',style:TextStyle(fontWeight: FontWeight.w300,color: Colors.white,fontSize: 18.0)),
                  onPressed: (){
                   fetchData("wallpaper",20);
                  },
                ),
              ),
            )
          ],
        ),
      );
    }
     else if(hasData){
       return Container(
         padding: EdgeInsets.all(5.0),
         child: TabBarView(
           children: <Widget>[
             WallpaperPage(pixelObject,fetchData), SearchPage()
           ],
           controller: tabController,
         ),
       );
     }
    else{
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("No Photos Found!",style:TextStyle(fontWeight: FontWeight.w300,color: Colors.amber,fontSize: 18.0)),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
            ),
            Icon(Icons.warning,color: Colors.amber,)
          ],
        ),
      );
    }
  }
  /*
  bottomNavAnimated(){
    if(!showSearch){
      return TabBar(
        isScrollable: false,
        indicatorColor: Colors.amber,
        tabs: <Widget>[
          tab('Images', Icon(Icons.image,color: Colors.amber,)),tab('Search', Icon(Icons.search,color: Colors.amber,)),
        ],
        controller: tabController,
      );
    }
    else{
      return
    }

  }
   */
}

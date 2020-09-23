import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hindi_2/ui/photoView.dart';
import 'package:hindi_2/ui/pixelObject.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  PixelObject pixelObject;
  String query;
  bool hasInternet;
  bool hasData;
  http.Response data;
  int pageNumber = 0;
  bool isLoading = true;
  var decodedJson;
  Map<String,String> authHeader = {
    "Authorization":"563492ad6f917000010000012a05cc0bd7be476ba7bd8db94e6d9573"
  };
  incPageNumber(){
    pageNumber++;
  }
  Future<void> fetchData(String query , int perPage) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ) {
      //print('connected to mobile data or wifi');
      hasInternet = true;
      incPageNumber();
      try{
        data = await http.get("https://api.pexels.com/v1/search?query=${query.trim().toLowerCase()}&per_page=$perPage&page=$pageNumber",headers: authHeader);
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
  /*

   */
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        pixelObject == null ? Padding(padding: EdgeInsets.only(top: 120.0),
            child: Center(child: Text("Nothing Yet!",style:TextStyle(fontWeight: FontWeight.w300,color: Colors.amber,fontSize: 18.0)))) : RefreshIndicator(
          onRefresh: (){
            //print('here1');
            return fetchData(query, 20);
          },
          child: ListView.builder(
            shrinkWrap: true,
           // physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Hero(
                            child: GestureDetector(
                              child: CachedNetworkImage(
                                imageUrl: pixelObject.photos[index].src.landscape,
                                placeholder: (context,url) => Padding(padding: EdgeInsets.all(2.0),child: CircularProgressIndicator(backgroundColor: Colors.amber,valueColor: AlwaysStoppedAnimation<Color>(Colors.black),)),
                                errorWidget: (context,url,error)=> Icon(Icons.error),
                              ),
                              onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) =>  PhotoPage(url: pixelObject.photos[index].src.original,)
                               ) );
                              },
                            ),
                            tag: pixelObject.photos[index].src.original,
                          ),),
                      // Padding(padding: EdgeInsets.only(top: 4.0),),
                      Container(
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0)),
                          ),
                          child: Text(
                            pixelObject.photos[index].photographer,
                            style: TextStyle(
                                fontWeight: FontWeight.w300, color: Colors.black),
                          ))
                    ],
                  ),
                  padding: EdgeInsets.only(top: 3.0, bottom: 3.0));
            },
            itemCount: pixelObject.photos.length,
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
              prefixIcon: Icon(Icons.search,color: Colors.amber,),
              hintText: "Search",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
              ),
            ),
            cursorColor: Colors.amber,
            showCursor: true,
            autofocus: true,
            onFieldSubmitted: (String text) {
              setState(() {
                pageNumber = 0;
                query = text;
              });
              fetchData(text, 20);
            },
          ),
        ),
      ],
    );
    ;
  }
}

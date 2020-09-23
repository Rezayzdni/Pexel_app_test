import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hindi_2/ui/Tabs.dart';
import 'package:redux/redux.dart';
import 'package:hindi_2/ui/counterState.dart';
import 'package:hindi_2/ui/reducer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MainApp());
}

enum Action{Inc , Double , Product_5 , Dec}

class MainApp extends StatelessWidget {
 // final Store store = Store<CounterState>(reducers,initialState: CounterState(0) );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Tabs(),
      theme: ThemeData.dark(),
    );
  }
}
/*
 StoreProvider<CounterState>(
      store: store,
      child:
    )
Scaffold(
          appBar: AppBar(
            title: Text("Redux Example"),
          ),
          body:Center(child: MyColumn()),
        ),
      ),
 */
class MyColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<CounterState , CounterState>(
      converter: (store) => store.state,
      builder: (context , state){
       return Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Text("the value of counter is : " + state.counter.toString()),
           StoreConnector<CounterState,Function>(
             converter: (store){
               return (action) => store.dispatch(action);
             },
             builder: (context , callBack){
               return Column(
                 children: <Widget>[
                   FlatButton(
                     child: Text("add"),
                     onPressed: (){
                       callBack(Action.Inc);
                     },
                   ),
                   FlatButton(
                     child: Text("Double"),
                     onPressed: (){
                       callBack(Action.Double);
                     },
                   ),
                   FlatButton(
                     child: Text("product_5"),
                     onPressed: (){
                       callBack(Action.Product_5);
                     },
                   ),
                   FlatButton(
                     child: Text("Dec"),
                     onPressed: (){
                       callBack(Action.Dec);
                     },
                   ),
                 ],
               );
             },
           )
         ],
       );
      }
    );
  }
}


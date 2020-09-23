import 'package:flutter/material.dart';

class Theming extends StatefulWidget {
  @override
  _ThemingState createState() => _ThemingState();
}

class _ThemingState extends State<Theming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theming",
        style: Theme.of(context).textTheme.headline1,),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Theme(
            child:Text(
              "sasa"
          ),
            data: ThemeData(
              brightness: Brightness.light,
              splashColor: Colors.lime,
              primaryColor: Colors.deepOrange
            ),
          ),
        ),
      ),
    );
  }
}

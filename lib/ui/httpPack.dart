import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String url = "http://txt2html.sourceforge.net/sample.txt";
  bool isLoading;
  http.Response data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    fetchData();

  }

  Future<void> fetchData() async{
    data = await http.get(url);
    isLoading = false;
    setState(() {

    });
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("http package"),
      ),
      body: Center(
        child: isLoading ? CircularProgressIndicator() : RefreshIndicator(
          onRefresh: (){
            return fetchData();
          },
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(this.data.body.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


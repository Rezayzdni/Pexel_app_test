import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hindi_2/ui/photoView.dart';
import 'package:hindi_2/ui/pixelObject.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hindi_2/util/downloadFiles.dart';
class WallpaperPage extends StatefulWidget {
  final PixelObject pixelObject;
  final Function(String , int) fetchFunc;
  WallpaperPage(this.pixelObject,this.fetchFunc);
  @override
  _WallpaperPageState createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  ReceivePort _port = ReceivePort();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_bindBackgroundIsolate();

    //FlutterDownloader.registerCallback(downloadCallback);
  }
  /*
  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      if (true) {
        print('UI Isolate Callback: $data');
      }
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      /*
      final task = _tasks?.firstWhere((task) => task.taskId == id);
      if (task != null) {
        setState(() {
          task.status = status;
          task.progress = progress;
        });
      }
       */
    });
  }
   */

 /*
  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    if (true) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }
  */
  @override
  Widget build(BuildContext context) {
    //print('length is : ${widget.pixelObject.photos.length}');
    return RefreshIndicator(
      color: Colors.amber,
      onRefresh: (){
        //print('here1');
        return widget.fetchFunc("wallpaper",20);
      },
      child: ListView.builder(shrinkWrap:true ,
          itemBuilder: (context,index){
      return Padding(
          child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Hero(
                      tag: widget.pixelObject.photos[index].src.original,
                      child: GestureDetector(
                        /*
                        child: Image.network(
                            widget.pixelObject.photos[index].src.landscape),
                         */
                        child: CachedNetworkImage(
                          imageUrl: widget.pixelObject.photos[index].src.landscape,
                          placeholder: (context,url) => Padding(padding: EdgeInsets.all(2.0),child: CircularProgressIndicator(backgroundColor: Colors.amber,valueColor: AlwaysStoppedAnimation<Color>(Colors.black),)),
                          errorWidget: (context,url,error)=> Icon(Icons.error),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  PhotoPage(url: widget.pixelObject.photos[index].src.original,)
                          ) );
                        },
                        onLongPress: (){
                          debugPrint(widget.pixelObject.photos[index].url);
                        },
                      ),
                    ),),
               // Padding(padding: EdgeInsets.only(top: 4.0),),
                  Container(
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0),bottomRight: Radius.circular(5.0)),
                      ),
                      child: Text(widget.pixelObject.photos[index].photographer,style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black),)),
               /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 // mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0),bottomRight: Radius.circular(5.0)),
                        ),
                        child: MaterialButton(
                            onPressed: (){
                              DownloadFiles downloadFiles = DownloadFiles();
                              downloadFiles.getTheShitDone(widget.pixelObject.photos[index].url);
                            },
                            child: Icon(Icons.file_download))),

                  ],
                )
                */
              ],),
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0)
      );
      },itemCount: widget.pixelObject.photos.length),
    );
  }
}

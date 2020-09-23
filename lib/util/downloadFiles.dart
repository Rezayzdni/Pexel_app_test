import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:async';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'package:path_provider/path_provider.dart';

class DownloadFiles{
  bool _permissionReady = false;
  TargetPlatform platform;
  //ReceivePort _port = ReceivePort();
  String getStandardDownloadFormat(String url){
    print(url);
    var list_0 = [];
    var list_1 = [];
    list_0 = url.split("/");
    print("list is : $list_0");
    String tmpStr = list_0[list_0.length - 2];
    print("the tmp is : $tmpStr");
    list_1 = tmpStr.split("-");
    print(list_1[list_1.length - 1]);
    list_0[list_0.length - 2] = list_1[list_1.length - 1];
    tmpStr = list_0.join("/") + "download/";
    print(tmpStr);
    return tmpStr;
  }
  void getTheShitDone (String url)async
  {
    _permissionReady = await _checkPermission();
    if(_permissionReady){
      startDownload(url);
    }
    else{
      print("permission denied");
    }
  }
  void startDownload(String url)async{
    //var theDir = (await _findLocalPath()) + Platform.pathSeparator;

    var theDir = (await _findLocalPath()) + Platform.pathSeparator;
    print("the dir is : $theDir");
    final taskId = await FlutterDownloader.enqueue(
      url: getStandardDownloadFormat(url),
      savedDir: theDir,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
  }

  Future<String> _findLocalPath() async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }



  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
/*



 */
}

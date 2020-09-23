import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class PhotoPage extends StatefulWidget {
  final String url;
  PhotoPage({@required this.url});
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: widget.url,
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(
            widget.url
          ),

          /*
          minScale: MediaQuery.of(context).size.height*.5,
          maxScale: MediaQuery.of(context).size.height*2,
           */
        ),
      ),
    );
  }
}

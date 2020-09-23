import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
class ClipMilip extends StatefulWidget {
  @override
  _ClipMilipState createState() => _ClipMilipState();
}

class _ClipMilipState extends State<ClipMilip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("clipers",
        style: Theme.of(context).textTheme.headline1,),elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          ClipOval(child: Image.network("https://www.w3schools.com/getcertified.jpg")),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network("https://www.w3schools.com/getcertified.jpg")),
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 60.0,
            ),
          )
        ],
          ),
        /*
        Image(
          image: NetworkImage(
            "https://www.w3schools.com/w3css/img_lights.jpg"
          ),
        )
         */
    );
  }
}

/*
{
  "id": 2014422,
  "width": 3024,
  "height": 3024,
  "url": "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
  "photographer": "Joey Farina",
  "photographer_url": "https://www.pexels.com/@joey",
  "photographer_id": 680589,
  "src": {
    "original": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg",
    "large2x": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "large": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
    "medium": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350",
    "small": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130",
    "portrait": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
    "landscape": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
    "tiny": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
  }
}

 */

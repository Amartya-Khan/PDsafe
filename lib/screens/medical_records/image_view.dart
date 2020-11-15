import 'package:flutter/material.dart';

class ImageExp extends StatefulWidget {
  String medical;
  ImageExp({this.medical});
  @override
  _ImageExpState createState() => _ImageExpState();
}

class _ImageExpState extends State<ImageExp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Medical",
            style: TextStyle(color: Colors.black),
          ),
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }),
          backgroundColor: Colors.white10,
          elevation: 0,
        ),
        body: Center(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new NetworkImage(widget.medical),
                  fit: BoxFit.fitWidth)),
        )));
  }
}

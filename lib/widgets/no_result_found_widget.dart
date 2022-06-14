import 'package:flutter/cupertino.dart';

Widget noResultFoundWidget(){
  return Center(child: Column(
    children: [
      Image.asset("assets/gifs/noMatchFoundGif-transparent.gif"),
      const Text("No Places Found",style: TextStyle(fontSize: 18),)
    ],
  ));
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class GetCustomModel extends StatefulWidget {
  const GetCustomModel({super.key});

  @override
  State<GetCustomModel> createState() => _GetCustomModelState();
}

class _GetCustomModelState extends State<GetCustomModel> {
 
  List<Photos> photoList=[];
  Future<List<Photos>> getPhotos() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    
    if(response.statusCode==200){
      for(Map<String,dynamic> i in data){
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photoList.add(photos);
      }
      return photoList;
    }else{
      return photoList;
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Model Api get"),
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getPhotos(),
            builder: (context,AsyncSnapshot<List<Photos>> snapshot){
              return ListView.builder(
                itemCount: photoList.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data![index].url.toString()),

                      ),
                      subtitle: Text(snapshot.data![index].title.toString()),
                      title: Text('Notes id:'+snapshot.data![index].id.toString()),
                    );
                  },
              );
            },
          ))
        ],
      ),
    );
  }
}

class Photos{
  String title,url;
  int id;
  Photos({required this.title, required this.url,required this.id});
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/PostModel.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GetFirstModel> postList=[];
  
  Future<List<GetFirstModel>> getPostApi() async{
    final resonse = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(resonse.body.toString());

    if(resonse.statusCode==200){
      for(Map <String,dynamic> i in data){
        postList.add(GetFirstModel.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Course"),
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getPostApi(),
            builder: (context,snapshot){
              if(!snapshot.hasData){
                return Text("Loading");
              }else{
                return ListView.builder(
                    itemBuilder:(context,index){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Title:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              Text(postList[index].title.toString()),
                              SizedBox(height: 15,),
                              Text("Description:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              Text(postList[index].body.toString()),
                            ],
                          ),
                        ),
                      );
                    });
              }
            },

          ))
        ],
      ),
    );
  }
}

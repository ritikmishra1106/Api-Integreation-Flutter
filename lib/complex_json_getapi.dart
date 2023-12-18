import 'dart:convert';

import 'package:flutter/material.dart';

import 'Models/user_model_dart.dart';
import 'package:http/http.dart' as http;
class ComlexJsonGetScreen extends StatefulWidget {
  const ComlexJsonGetScreen({super.key});

  @override
  State<ComlexJsonGetScreen> createState() => _ComlexJsonGetScreenState();
}

class _ComlexJsonGetScreenState extends State<ComlexJsonGetScreen> {
  List<ComlexGetModel> userList = [];
  Future<List<ComlexGetModel>> getUserApi() async{
    final response =  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for(Map<String,dynamic> i in data){
        userList.add(ComlexGetModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COmlex Json"),
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context,AsyncSnapshot<List<ComlexGetModel>>snapshot){
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }else{
                return ListView.builder(
                  itemCount: userList.length,
                    itemBuilder: (context,index){
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ReusbalRow(title: 'Name', value: snapshot.data![index].name.toString()),
                            ReusbalRow(title: 'Name', value: snapshot.data![index].username.toString()),
                            ReusbalRow(title: 'Name', value: snapshot.data![index].address!.city.toString()),
                            ReusbalRow(title: 'Name', value: snapshot.data![index].address!.geo!.lat.toString()),
                          ],
                        ),
                      ),
                    );
                    }
                );
              }
            },
          ))
        ],
      ),
    );
  }
}

class ReusbalRow extends StatelessWidget {
  String title,value;
   ReusbalRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value)
        ],
      ),
    );
  }
}

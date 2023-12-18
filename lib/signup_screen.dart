import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpPostApi extends StatefulWidget {
  const SignUpPostApi({super.key});

  @override
  State<SignUpPostApi> createState() => _SignUpPostApiState();
}

class _SignUpPostApiState extends State<SignUpPostApi> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController= TextEditingController();
  
  void login(String email,password) async{
    try{
      Response response = await post(Uri.parse('https://reqres.in/api/register'),
      body: {
        'email':email,
        'password':password
      });
      if(response.statusCode==200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Account created SuccessFully');
      }else{
        print('Failed');
      }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign Up APi",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email"
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: "password"
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),),
              ),
            )
          ],
        ),
      ),
    );
  }
}

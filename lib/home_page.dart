import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_ap1/Models/PostModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Store all data form PostModel class
  List<PostModel> postModel = [];

  /// This method using fetch data from online
  /// which is called API get data
  Future<List<PostModel>> getPostData() async{
    final responseData = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(responseData.body.toString());
    if(responseData.statusCode == 200){
      for(Map i in data){
        postModel.add(PostModel.fromJson(i));
      }
      return postModel;
    }else{
      return postModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn API'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('Something wrong');
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: postModel.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        title: Text(postModel[index].title.toString()),
                        subtitle: Text(postModel[index].body.toString()),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

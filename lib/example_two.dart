import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({Key? key}) : super(key: key);

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {

  /// Store all data form PostModel class
  List<PhotoModel> photoList = [];

  /// This method using fetch data from online
  /// which is called API get data
  Future<List<PhotoModel>> getPhotoData() async{
    final responseData = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(responseData.body.toString());

    if(responseData.statusCode == 200){
      for(Map i in data){
        /// PhotoModel is modelClass
        /// Which hit the api and get data
        PhotoModel photoModel = PhotoModel(title: i['title'], url: i['url'],id: i['id']);
        photoList.add(photoModel);
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
        title: Text('ExampleTwo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotoData(),

              /// to get PhotoModel class data using snapshot
              /// define AsyncSnapshot<List<PhotoModel>>
              /// data will come with List
              builder: (context, AsyncSnapshot<List<PhotoModel>> snapshot){
                if(snapshot.hasError){
                  print('Something wrong');
                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

               return ListView.builder(
                 itemCount: photoList.length,
                 itemBuilder: (context,index){
                   return Card(child: ListTile(
                     title: Text('ID: '+ snapshot.data![index].id.toString()),
                     subtitle : Text(snapshot.data![index].title.toString()),
                     leading : CircleAvatar(
                       backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                     ),
                   ));
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

class PhotoModel {
  final String title;
  final String url;
  final int id;

  PhotoModel({required this.title, required this.url,required this.id});
}

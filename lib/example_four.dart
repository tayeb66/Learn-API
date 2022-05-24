import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_ap1/Models/ProductsModel.dart';

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {

  Future<ProductsModel> getProducts()async{
    final response = await http.get(Uri.parse('https://webhook.site/5d8123df-e6fe-44f7-af0d-fbd1e1df9f95'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }else{
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExampleFour'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductsModel>(
              future: getProducts(),
              builder: (context, snapshot){
                if(snapshot.hasError){
                  print('something wrong');
                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height *.3,
                        width: MediaQuery.of(context).size.height *1,
                        child: ListView.builder(
                          itemBuilder: (context,position){
                            return Container(
                              height: MediaQuery.of(context).size.height *.25,
                              width: MediaQuery.of(context).size.height *.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data!.data![index].products![position].toString()),
                                )
                              ),
                            );
                          },
                          itemCount: snapshot.data!.data![index].image!.length,
                        ),
                      ),

                    ],
                  );
                  }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

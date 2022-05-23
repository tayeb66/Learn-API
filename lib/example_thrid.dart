import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learn_ap1/Models/UserModel.dart';
import 'package:http/http.dart' as http;

class ExampleThird extends StatefulWidget {
  const ExampleThird({Key? key}) : super(key: key);

  @override
  State<ExampleThird> createState() => _ExampleThirdState();
}

class _ExampleThirdState extends State<ExampleThird> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserList() async {
    final responseData =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(responseData.body.toString());

    if (responseData.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }

      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExampleThird'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserList(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapShot) {
                if (snapShot.hasError) {
                  print('Something wrong');
                } else if (snapShot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            UsebleRow(title:'id', value:  snapShot.data![index].id.toString()),
                            UsebleRow(title: 'Name', value: snapShot.data![index].name.toString()),
                            UsebleRow(title: 'UserName', value: snapShot.data![index].username.toString()),
                            UsebleRow(title: 'Email', value: snapShot.data![index].email.toString()),
                            UsebleRow(title: 'Address', value: snapShot.data![index].address!.geo!.lat.toString())

                          ],
                        ),
                      ),
                      // child: ListTile(
                      //   title: Text(snapShot.data![index].name.toString()),
                      //   leading: Text(snapShot.data![index].id.toString()),
                      //   subtitle: Text(snapShot.data![index].email.toString()),
                      //   trailing: Text(
                      //       snapShot.data![index].company!.name.toString()),
                      // ),
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

class UsebleRow extends StatelessWidget {
  final String title, value;

  const UsebleRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

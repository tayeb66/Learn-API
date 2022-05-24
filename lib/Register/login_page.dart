import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:learn_ap1/Register/signUp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  /// Sending http request using This method
  /// using post() API & hit server
  /// after post() successfully then response data from server
  Future<void> signUp(email, password) async {
    ///Send an HTTP POST to server through post()
    Response response = await post(Uri.parse('https://reqres.in/api/register'),
        body: {'email': email, 'password': password});

    /// response from server and check id
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      print('Login Successful');
    } else {
      print('Login UnSuccessful');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('LoginPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          elevation: 0.0,
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: emailController,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter UserName',
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                    minimumSize: Size(200, 50), shape: StadiumBorder()),
                onPressed: () {
                  signUp(emailController.text.toString(),
                      passwordController.text.toString());
                },
                child: Text(
                  'Login',
                  textScaleFactor: 1.2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Create a account ? '),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Text('SignUp'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

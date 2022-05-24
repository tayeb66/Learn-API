import 'package:flutter/material.dart';
import 'package:learn_ap1/Register/login_page.dart';
import 'package:http/http.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  /// This method using post API & hit server
  /// after post successfully then response data
  Future<void> login(email, password) async {

    try{
      ///Send an HTTP POST to server through post()
      Response response = await post(Uri.parse('https://reqres.in/api/register'),
          body: {'email': email, 'password': password});

      /// response from server and check id
      if(response.statusCode == 200){
        print('SignUp Successful');
      }else{
        print('SignUp UnSuccessful');
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('SignUpPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          color: Colors.white,
          elevation: 0.0,
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
                  login(emailController.text.toString(),
                      passwordController.text.toString());
                },
                child: Text(
                  'SignUp',
                  textScaleFactor: 1.2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Have an account ?'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text('Login'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

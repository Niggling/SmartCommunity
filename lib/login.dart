import '/PropertyClient/home.dart';
import '/ResidentClient/residentHome.dart';
import '/peizhi/global.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

String datakey='';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameEditingController=new TextEditingController();
  TextEditingController passwordEditingController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('智慧社区'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameEditingController,
              decoration: InputDecoration(labelText: '请输入用户名'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordEditingController,
              decoration: InputDecoration(labelText: '请输入密码'),
              obscureText: true,
            ),
            SizedBox(height: 16.0,),
            ElevatedButton(onPressed: () {
              loadDataDio();
              if (datakey == 'xushang') {
                  manager_main();
              } else if (datakey == 'yvyvyang') {
                  resident_main();
              }
            }, child: Text("登陆")),
            ElevatedButton(
                onPressed: () {
                  _showRegisterDialog();
                },
                child: Text('注册账号'),
              style:ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }
  void  _showRegisterDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('注册'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: '用户名'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: '密码'),
                  obscureText: true,
                )
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('取消')),
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child:Text('注册'))
            ],
          );
        });
  }
  void loadDataDio() /*async{
    Response response;
    Dio dio=Dio();
    response=await dio.post(
      "接口地址", data: {"username":usernameEditingController,"password":passwordEditingController}
    );
  String? cookie = response.headers.value('set-cookie');
      CookieManager.setAuthToken(cookie!);
    datakey= response.data.toString();
}*/{
    datakey=usernameEditingController.text;
  }
}

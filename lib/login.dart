import '/PropertyClient/home.dart';
import '/ResidentClient/residentHome.dart';
import '/peizhi/global.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

String datakey='';

class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "登陆",
      home: Scaffold(
          appBar: AppBar(
            title: Text("智慧社区"),
          ),
          body:
            Container(child: Center(child: LoginPageResident(),),)
        ),
    );
  }
}
TextEditingController usernameEditingController=new TextEditingController();
TextEditingController passwordEditingController=new TextEditingController();

class LoginPageResident extends StatelessWidget{
  const LoginPageResident({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameEditingController,
              decoration: InputDecoration(labelText: '请输入用户名'),
            ),
            TextField(
              controller: passwordEditingController,
              decoration: InputDecoration(labelText: '请输入密码'),
              obscureText: true,
            ),
            SizedBox(height: 8.0,),
            ElevatedButton(onPressed: (){
              loadDataDio();
              if(datakey=='200') {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RHomePage();
                }));
              }else if(datakey=='300') {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PHomePage();
                }));
              }
            }, child: Text("登陆")),
          ],
        ),
      ),
    );
  }

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
  datakey='200';
}

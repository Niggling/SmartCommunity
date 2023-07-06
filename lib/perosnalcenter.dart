import 'package:flutter/material.dart';
import '/Authentication.dart';
import 'login.dart';

List<String> personal = ["徐尚","657803436@qq.com"];
class PersonalCenterPage extends StatelessWidget {
  @override

  TextEditingController _nickname = TextEditingController();
  TextEditingController _email = TextEditingController();
  void setpersonal(String nickname,String email){

      personal[0] = nickname;
      personal[1] = email;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          UserHeader(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('个人信息'),
            onTap: () {
              // 处理个人信息点击事件
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('个人信息'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('性别：男'),
                      Text('年龄：25'),
                      Text('名下的房屋：22栋201'),
                      Text('名下的车辆：大众朗逸,宝马s5'),
                      Text('家人：母亲：大苏打，父亲：徐手机'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('关闭'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                title: Text('个人信息修改'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _nickname,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: "昵称",
                          hintText: "不要超过20个字符",
                          prefixIcon: Icon(Icons.person)
                      ),
                    ),
                    TextField(
                      controller: _email,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: "邮箱",
                          hintText: "支持10+种邮箱",
                          prefixIcon: Icon(Icons.mail)
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setpersonal(_nickname.text,_email.text);
                      Navigator.pop(context);
                    },
                    child: Text('确认'),
                  ),
                ],
              ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('退出登录'),
            onTap: () {
              // 处理个人信息点击事件
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('退出登录'),
                  content: Text("你确定要退出登录吗？"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => MyApp()),);
                      },
                      child: Text('确定'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );

  }
}

class UserHeader extends StatefulWidget {
  @override
  _UserHeaderState createState() => _UserHeaderState();

}

class _UserHeaderState extends State<UserHeader> {

  List<String> _inside = personal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/head.webp'),
            // 替换为本地图片的路径
          ),
          SizedBox(height: 10),
          Text(
            _inside[0], // 替换为用户名称
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _inside[1], // 替换为用户邮箱
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: PersonalCenterPage(),
  ));
}

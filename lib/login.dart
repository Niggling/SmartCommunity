import '/PropertyClient/home.dart';
import '/ResidentClient/residentHome.dart';
import '/peizhi/global.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

String datakey = '';
TextEditingController usernameEditingController = new TextEditingController();
TextEditingController passwordEditingController = new TextEditingController();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '智慧社区',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//定义全局获取颜色的方法
Color getRandomWhiteColor(Random random) {
  //透明度0～200 255是不透明
  int a = random.nextInt(200);
  return Color.fromARGB(a, 255, 255, 255);
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<BobbleBean> _list = [];

  //随机数
  Random _random = new Random(DateTime.now().millisecondsSinceEpoch);
  double _maxSpend = 1.0;
  double _maxRadius = 100;
  double _maxThate = 2 * pi;

  late AnimationController _animationController;
  late AnimationController _fadeAnimationController;

  void initState() {
    setState(() {
      for (int i = 0; i < 20; i++) {
        BobbleBean bean = new BobbleBean();
        print(i);
        bean.color = getRandomWhiteColor(_random);
        //设置位置 先来个默认的
        bean.position = Offset(-1, -1);
        bean.spend = _random.nextDouble() * _maxSpend;
        bean.radius = _random.nextDouble() * _maxRadius;
        bean.theta = _random.nextDouble() * _maxThate;
        _list.add(bean);
      }
      //创建动画一秒
      _animationController = new AnimationController(
          vsync: this, duration: Duration(microseconds: 1000));
      //执行刷新监听
      _animationController.addListener(() {
        setState(() {});
      });
      //重复执行

      // _animationController.repeat();
      _fadeAnimationController = new AnimationController(
          vsync: this, duration: Duration(microseconds: 1800));
      //执行刷新监听
      _fadeAnimationController.forward();
      _fadeAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.repeat();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          //渐变背景
          buildBackground(),
          //气泡
          buildBobbleWidget(context),
          //高斯模糊
          buildBlurWidget(),
          buildBottomWidget(context),
        ],
      ),
    ));
  }

  buildBobbleWidget(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: CustomMyPainter(list: _list, random: _random),
    );
  }

  buildBlurWidget() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: .3, sigmaY: .3),
      child: Container(
        color: Colors.white.withOpacity(0.1),
      ),
    );
  }

  buildBottomWidget(BuildContext context) {
    return Positioned(
        bottom: 200,
        left: 40,
        right: 40,
        child: FadeTransition(
          opacity: _fadeAnimationController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFileWidget(
                EditingController: usernameEditingController,
                obscuretext: false,
                labelText: '用户名',
                prefixIconData: Icons.phone_android,
                onChanged: (String value) {},
                suffixIconData: Icons.phone_android,
              ),
              SizedBox(
                height: 14,
              ),
              TextFileWidget(
                EditingController: passwordEditingController,
                obscuretext: true,
                labelText: '密码',
                suffixIconData: Icons.visibility,
                prefixIconData: Icons.lock_outline,
                onChanged: (String value) {},
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  loadDataDio();
                  if (datakey == 'xushang') {
                    manager_main();
                  } else if (datakey == 'yuyuyang') {
                    resident_main();
                  }
                },
                child: Text("登陆"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  _showRegisterDialog(context);
                },
                child: Text('注册账号'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              )
              // Container(
              //   height: 38,
              //   width: double.infinity,
              //   child: ElevatedButton(
              //
              //   ),
              // )
            ],
          ),
        ));
  }
}

void _showRegisterDialog(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('取消')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('注册'))
          ],
        );
      });
}

void
    loadDataDio() /*async{
    Response response;
    Dio dio=Dio();
    response=await dio.post(
      "接口地址", data: {"username":usernameEditingController,"password":passwordEditingController}
    );
  String? cookie = response.headers.value('set-cookie');
      CookieManager.setAuthToken(cookie!);
    datakey= response.data.toString();
}*/
{
  datakey = usernameEditingController.text;
}

class TextFileWidget extends StatelessWidget {
  Function(String value) onChanged;
  bool obscuretext;
  String labelText;
  IconData prefixIconData;
  IconData suffixIconData;
  TextEditingController EditingController;

  TextFileWidget(
      {required this.onChanged,
      required this.labelText,
      required this.obscuretext,
      required this.suffixIconData,
      required this.prefixIconData,
      required this.EditingController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: EditingController,
      onChanged: onChanged,
      obscureText: obscuretext,
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14,
      ),
      decoration: InputDecoration(
          filled: true,
          labelText: labelText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.blue)),
          prefixIcon: Icon(
            prefixIconData,
            size: 18,
            color: Colors.blue,
          ),
          suffixIcon: Icon(
            suffixIconData,
            size: 18,
            color: Colors.blue,
          )),
    );
  }
}

class CustomMyPainter extends CustomPainter {
  List<BobbleBean> list = [];
  Random random;

  CustomMyPainter({required this.list, required this.random});

  //先来个画笔
  Paint _paint = new Paint()..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    //绘制前重新计算每个点的位置
    list.forEach((element) {
      Offset newCenterOffset = calcuLateXy(element.spend, element.theta);
      double dx = newCenterOffset.dx + element.position.dx;
      double dy = newCenterOffset.dy + element.position.dy;
      if (dx < 0 || dx > size.width) {
        dx = random.nextDouble() * size.width;
      }
      if (dy < 0 || dx > size.height) {
        dy = random.nextDouble() * size.height;
      }
      element.position = Offset(dx, dy);
    });
    list.forEach((element) {
      _paint.color = element.color;
      canvas.drawCircle(element.position, element.radius, _paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomMyPainter oldDelegate) {
    //返回false 不刷新
    return true;
  }

  Offset calcuLateXy(double spend, double theta) {
    return Offset(spend * cos(theta), spend * sin(theta));
  }
}

class buildBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.lightBlueAccent.withOpacity(0.3),
            Colors.lightBlue.withOpacity(0.3),
            Colors.blue.withOpacity(0.3)
          ])),
    );
  }
}

class BobbleBean {
  //位置
  late Offset position;

  //颜色

  late Color color;

  //速度
  late double spend;
  late double theta;
  late double radius;
}

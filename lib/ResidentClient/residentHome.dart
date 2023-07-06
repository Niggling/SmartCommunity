import 'package:workspace/ResidentClient/familyManagement.dart';
import 'package:flutter/material.dart';
import 'package:workspace/newsview.dart';
import 'package:workspace/perosnalcenter.dart';
import 'package:workspace/Authentication.dart';
import 'package:workspace/HouseManagement.dart';
import 'package:workspace/usercar.dart';
import 'package:workspace/ProblemReportPage.dart';
import 'package:workspace/vote_client.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<RHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widetOptions = [
    HomePage(),
    HomePage2(),
    HomePage3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("智慧社区居民端"),
      ),
      body: _widetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '公告查看'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '个人中心'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          color: Color(0xFFF2F2F2),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true, // 自动播放
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                    ),
                    items: [
                      Image.asset(
                        'assets/images/first_page.png',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/second_page.jpg',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/third_page.jpg',
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 350,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16), // 圆角半径
                      ),
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, //横向数量
                          mainAxisSpacing: 2, //行间距
                          crossAxisSpacing: 4, //水平间距
                          childAspectRatio: 0.8, //宽高比
                        ),
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.account_box,
                                color: Colors.blue,
                                size: 50.0,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "Authentication");
                                },
                                child: Text("实名认证"),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                          Column(children: [
                            Icon(
                              Icons.business,
                              color: Colors.red,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "HouseManagement");
                              },
                              child: Text("房屋管理"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ]),
                          Column(children: [
                            Icon(
                              Icons.group,
                              color: Colors.orange,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, "familyManagement");
                              },
                              child: Text("家人管理"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ]),
                          Column(children: [
                            Icon(
                              Icons.drive_eta,
                              color: Colors.green,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "usercar");
                              },
                              child: Text("车辆管理"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ]),
                          Column(children: [
                            Icon(
                              Icons.announcement,
                              color: Colors.yellow,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, "ProblemReportPage");
                              },
                              child: Text("问题上报"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ]),
                          Column(children: [
                            Icon(
                              Icons.insert_chart,
                              color: Colors.purple,
                              size: 50.0,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "vote_client");
                              },
                              child: Text("支出投票"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16)
                ],
              ),
            ),
          )),
    );
  }
}

class HomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsAppView();
  }
}

class HomePage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PersonalCenterPage();
  }
}

void resident_main() {
  runApp(MaterialApp(
    title: "首页",
    initialRoute: "Home",
    routes: {
      "Authentication": (context) => Authentication(),
      "HouseManagement": (context) => HouseManagementPage(),
      "familyManagement": (context) => FamilyPage(),
      "usercar": (context) => VehicleManagementPage(),
      "ProblemReportPage": (context) => ProblemReportPage(),
      "vote_client": (context) => VotingPage(),
      "Home": (context) => RHomePage(),
    },
  ));
}

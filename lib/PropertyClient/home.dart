
import 'package:flutter/material.dart';
import '/PropertyClient/PeopleManagement.dart';
import '/newslaunch.dart';
import 'package:workspace/newsview.dart';
import '/information_configure.dart';
import '/tenementcar.dart';
import '/EventHandlingPage.dart';
import '/vote_manager.dart';
import '/perosnalcenter.dart';


class PHomePage extends StatefulWidget{

  @override
  _HomePageState createState() =>_HomePageState();
}
class _HomePageState extends State<PHomePage>{



  int _selectedIndex=0;
  static List<Widget>_widetOptions=[
    HomePage(),
    HomePage2(),
    HomePage3(),
  ];
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("智慧社区物业端"),
      ),
      body:
      _widetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '公告察看'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '个人中心'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),

    );
  }
}
class HomePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFF2F2F2),
        child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child:
            Column(
              children: [
                SizedBox(height: 16,),
                Container(
                  child: Image.asset(
                    'assets/images/first_page.png',
                    width:double.infinity,
                    height:200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 250,
                  child:Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16), // 圆角半径
                    ),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,//横向数量
                        mainAxisSpacing: 2,//行间距
                        crossAxisSpacing: 4,//水平间距
                        childAspectRatio: 1.0,//宽高比
                      ),
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.drafts,
                              color: Colors.blue,
                              size: 50.0,
                            ),
                            SizedBox(height: 8.0,),
                            ElevatedButton(
                              onPressed: (){
                                Navigator.pushNamed(context, "newslanch");
                              },
                              child: Text("公告发布"),
                              style:ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                            children:[
                              Icon(
                                Icons.exposure,
                                color: Colors.blue,
                                size: 50.0,
                              ),
                              SizedBox(height: 8.0,),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, "information_configure");
                                },
                                child: Text("信息配置"),
                                style:ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                              ),
                            ]
                        ),
                        Column(
                            children:[
                              Icon(
                                Icons.account_box,
                                color: Colors.blue,
                                size: 50.0,
                              ),
                              SizedBox(height: 8.0,),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, "PeopleManagement");
                                },
                                child: Text("居民管理"),
                                style:ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                              ),
                            ]
                        ),
                        Column(
                            children:[
                              Icon(
                                Icons.airport_shuttle,
                                color: Colors.blue,
                                size: 50.0,
                              ),
                              SizedBox(height: 8.0,),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, "tenementcar");
                                },
                                child: Text("车辆审核"),
                                style:ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                              ),
                            ]
                        ),
                        Column(
                            children:[
                              Icon(
                                Icons.assignment_late,
                                color: Colors.blue,
                                size: 50.0,
                              ),
                              SizedBox(height: 8.0,),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, "EventHandlingPage");
                                },
                                child: Text("事件处理"),
                                style:ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                              ),
                            ]
                        ),
                        Column(
                            children:[
                              Icon(
                                Icons.folder_special,
                                color: Colors.blue,
                                size: 50.0,
                              ),
                              SizedBox(height: 8.0,),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, "vote_manager");
                                  print("被点击");
                                },
                                child: Text("投票管理"),
                                style:ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  ) ,
                )
              ],
            )
          ),

        )

    );
  }

}
class HomePage2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return NewsAppView();
  }
}
class HomePage3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return PersonalCenterPage();
  }

}

  void manager_main() {

    runApp(MaterialApp(
      title: "首页",
      initialRoute: "Home",
      routes: {
        "newslanch": (context) => NewsLaunchPage(),
        "information_configure": (context) => CommunityInfoPage(),
        "PeopleManagement": (context) => PeopleManagementPage(),
        "tenementcar": (context) => MyHomePage(),
        "EventHandlingPage": (context) => EventHandlingPage(),
        "vote_manager": (context) => VotingPage(),
        "Home": (context) => PHomePage(),
      },

    ));
}


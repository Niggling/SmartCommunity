import 'package:ddlwork/ResidentClient/familyManagement.dart';
import 'package:flutter/material.dart';

class RHomePage extends StatefulWidget{

  @override
  _HomePageState createState() =>_HomePageState();
}
class _HomePageState extends State<RHomePage>{
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
    return MaterialApp(
      title: "首页",
      home: Scaffold(
          appBar: AppBar(
            title: Text("智慧社区"),
          ),
        body:_widetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home),label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: '2'),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: '3'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),

      ),
    );
  }
}
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          color: Color(0xFFF2F2F2),
          child:Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 16,),
                Container(
                  child: Image.asset(
                    'images/firstpage.png',width:double.infinity,
                    height:200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30),
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
                            FlutterLogo(size: 50.0),
                            SizedBox(height: 8.0,),
                            ElevatedButton(
                              onPressed: (){
                              },
                              child: Text("实名认证"),
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
                              FlutterLogo(size: 50.0),
                              SizedBox(height: 8.0,),
                              ElevatedButton(
                                onPressed: (){
                                },
                                child: Text("房屋管理"),
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
                              FlutterLogo(size: 50.0),
                              SizedBox(height: 8.0,),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return FamilyPage();
                                  }));
                                },
                                child: Text("家人管理"),
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
                              FlutterLogo(size: 50.0),
                              SizedBox(height: 8.0,),
                              ElevatedButton(
                                onPressed: (){
                                },
                                child: Text("车辆管理"),
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
                              FlutterLogo(size: 50.0),
                              SizedBox(height: 8.0,),
                              ElevatedButton(
                                onPressed: (){
                                },
                                child: Text("问题上报"),
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
                              FlutterLogo(size: 50.0),
                              SizedBox(height: 8.0,),
                              ElevatedButton(
                                onPressed: (){
                                },
                                child: Text("支出投票"),
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
            ) ,
          )

      ),
    );
  }

}
class HomePage2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('2'),
    );
  }
}
class HomePage3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('3'),
    );
  }

}
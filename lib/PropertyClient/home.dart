
import 'package:flutter/material.dart';
import 'package:ddlwork/PropertyClient/PeopleManagement.dart';

class PHomePage extends StatefulWidget{

  @override
  _HomePageState createState() =>_HomePageState();
}
class _HomePageState extends State<PHomePage>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "首页",
      home: Scaffold(
          appBar: AppBar(
            title: Text("智慧社区"),
          ),
          body:
           Container(
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
                                FlutterLogo(size: 50.0),
                                SizedBox(height: 8.0,),
                                ElevatedButton(
                                  onPressed: (){
                                  },
                                  child: Text("新闻发布"),
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
                                  FlutterLogo(size: 50.0),
                                  SizedBox(height: 8.0,),
                                  ElevatedButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return PeopleManagementPage();
                                      }));
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
                                  FlutterLogo(size: 50.0),
                                  SizedBox(height: 8.0,),
                                  ElevatedButton(
                                    onPressed: (){
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
                                  FlutterLogo(size: 50.0),
                                  SizedBox(height: 8.0,),
                                  ElevatedButton(
                                    onPressed: (){
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
                                  FlutterLogo(size: 50.0),
                                  SizedBox(height: 8.0,),
                                  ElevatedButton(
                                    onPressed: (){
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
                ) ,
              )

          )

      ),
    );
  }
}
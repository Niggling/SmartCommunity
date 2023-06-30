import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class FamilyPage extends StatefulWidget{
  @override
  _FamilyState createState() =>_FamilyState();
}
class _FamilyState extends State<FamilyPage>{
  List<Person> family = [
    //Person(name: '余', age: 20,IDcard:'1234566',),
    //Person(name: '庆', age: 25,IDcard:'1234567',),
    //Person(name: '清', age: 30,IDcard:'1234568',),
    // 可根据实际情况添加更多家人信息
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("智慧社区-家人管理"),
        ),
        body: ListView.builder(
          itemCount: family.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(family[index].name),
              subtitle: Text('年龄：${family[index].age}岁'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                _showPersonDetails(family[index]);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showAddDialog();
            },
            child: Icon(Icons.add),
          ),
      );
  }
  late BuildContext dialogContext;
  void _showPersonDetails(Person person) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context; // 将当前上下文赋值给 dialogContext
        TextEditingController nameController=TextEditingController(text: person.name);
        TextEditingController ageController=TextEditingController(text: person.age.toString());
        TextEditingController idController=TextEditingController(text: person.IDcard);
        return AlertDialog(
          title: Text(person.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: '姓名'),
                controller: nameController,
                onChanged: (value) {
                  person.name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '年龄'),
                controller: ageController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  person.age = int.parse(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '身份证号'),
                controller: idController,
                onChanged: (value) {
                  person.IDcard = value;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text('保存'),
              onPressed: () {
                // 执行保存操作，例如打印修改后的家人列表
                setState(() {}); // 触发界面重新构建
                Navigator.of(dialogContext).pop(); // 关闭弹窗
              },
            ),

            ElevatedButton(
              child: Text('关闭'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // 关闭弹窗
              },
            ),
          ],
        );
      },
    );
  }
  void _showAddDialog(){
    TextEditingController nameAddControlller=TextEditingController();
    TextEditingController ageAddController=TextEditingController();
    TextEditingController idAddController=TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("添加家人信息"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameAddControlller,
                  decoration: InputDecoration(labelText: "姓名"),
                ),
                TextField(
                  controller: ageAddController,
                  decoration: InputDecoration(labelText: "年龄"),
                ),
                TextField(
                  controller: idAddController,
                  decoration: InputDecoration(labelText: "身份证号"),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    String name=nameAddControlller.text;
                    int age=int.tryParse(ageAddController.text)??0;
                    String id= idAddController.text;
                    if(name.isNotEmpty&&age>0){
                      setState(() {
                        family.add(Person(name:name,age: age,IDcard: id));
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("确认")),
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("取消"))
            ],
          );
        }
    );
  }

}
class Person {
  String name;
  int age;
  String IDcard;

  Person({required this.name, required this.age,required this.IDcard});
}





import 'package:flutter/material.dart';

class PeopleManagementPage extends StatefulWidget{
  @override
  _PeopleManagementState createState() =>_PeopleManagementState();
}
class _PeopleManagementState extends State<PeopleManagementPage>{
  List<Resident> residents=[//居民信息
    Resident(name: '徐小', age: 20,address: "5-101"),
    Resident(name: '徐回', age: 25,address: "2-202"),
    Resident(name: '小回', age: 30,address: "2-203"),
    Resident(name: '打火机', age: 30,address: "22-201"),
    Resident(name: '余', age: 20,address: "1-101"),
  ];
  List<Resident> searchResults = [];//存储搜索到的信息
  List<Resident> pendingResidents = [
    Resident(name: "张三", age: 25,address: "1-303"), // 待审核的人员信息列表（示例数据）
    Resident(name: "李四", age: 30,address: "6-502"),
    Resident(name: "王五", age: 35,address: "3-102"),
  ];

  bool isSearching=false;

  void _searchResidents(String searchTerm){
    setState(() {
      searchResults=residents.where((resident)=>resident.name.toLowerCase().contains(searchTerm.toLowerCase())).toList();
      isSearching=true;
    });
  }
  void _updateResident(Resident resident, String newName, int newAge, String newAddress){
    setState(() {
      resident.name = newName;
      resident.age = newAge;
      resident.address = newAddress;
    });
  }
  void _showApprovalDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text("待审核人员信息"),
            content: ListView.builder(
              shrinkWrap: true,
              itemCount: pendingResidents.length,
                itemBuilder: (BuildContext context,int index){
                return ListTile(
                  title: Text(pendingResidents[index].name),
                  subtitle: Text('年龄:${pendingResidents[index].age},住址：${pendingResidents[index].address}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: (){
                            setState(() {
                              residents.add(pendingResidents[index]);
                              pendingResidents.removeAt(index);
                            });
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.check),
                        color: Colors.green,
                      ),
                      IconButton(
                          onPressed: (){
                            setState(() {
                              pendingResidents.removeAt(index);
                            });
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close),
                        color: Colors.red,
                      )
                    ],
                  ),
                );
                }),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("智慧社区-居民管理"),
          ),
          body: Column(
            children: [
              Padding(padding: const EdgeInsets.all(15.0),
                child: TextField(
                  onChanged: _searchResidents,
                  decoration: InputDecoration(hintText: '输入居民姓名进行搜索',suffixIcon: Icon(Icons.search)),
                ),
              ),
              Expanded(
                child: ListView.builder(
              itemCount: isSearching ? searchResults.length:residents.length,
              itemBuilder:(BuildContext context,int index) {
                final resident = isSearching
                    ? searchResults[index]
                    : residents[index];
                return ListTile(
                  title: Text(resident.name),
                  subtitle: Text(
                      '年龄：${resident.age} 住址：${resident.address}'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        TextEditingController nameController = TextEditingController(text: resident.name);
                        TextEditingController ageController = TextEditingController(text: resident.age.toString());
                        TextEditingController addressController = TextEditingController(text: resident.address);

                        return AlertDialog(
                          title: Text("修改居民信息"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(labelText: "姓名"),
                              ),
                              TextField(
                                controller: ageController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(labelText: "年龄"),
                              ),
                              TextField(
                                controller: addressController,
                                decoration: InputDecoration(labelText: "住址"),
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              child: Text("取消"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: Text("确认"),
                              onPressed: () {
                                String newName = nameController.text;
                                int newAge = int.tryParse(ageController.text) ??
                                    resident.age;
                                String newAddress = addressController.text;

                                // 更新居民信息
                                _updateResident(resident, newName, newAge, newAddress);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }
              )
    )
          ],
      ),
          floatingActionButton: FloatingActionButton(
            onPressed:(){
              _showApprovalDialog();
            },
            child: Icon(Icons.add),
          ),


    );
  }

}
class Resident{
  String name;
  int age;
  String address;
  Resident ({required this.name,required this.age,required this.address});
}
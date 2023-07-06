import 'package:flutter/material.dart';

class PeopleManagementPage extends StatefulWidget {
  @override
  _PeopleManagementState createState() => _PeopleManagementState();
}

class _PeopleManagementState extends State<PeopleManagementPage> {
  List<Resident> residents = [
    //居民信息
    Resident(name: '徐小', age: 20, address: "5-101"),
    Resident(name: '徐回', age: 25, address: "2-202"),
    Resident(name: '小回', age: 30, address: "2-203"),
    Resident(name: '打火机', age: 30, address: "22-201"),
    Resident(name: '余', age: 20, address: "1-101"),
    Resident(name: '张明', age: 25, address: "7-203"),
    Resident(name: '李红', age: 30, address: "2-305"),
    Resident(name: '王强', age: 22, address: "4-102"),
    Resident(name: '刘芳', age: 28, address: "6-204"),
    Resident(name: '陈宇', age: 19, address: "3-306"),
    Resident(name: '赵洋', age: 24, address: "1-103"),
    Resident(name: '孙萍', age: 31, address: "8-205"),
    Resident(name: '周林', age: 23, address: "9-307"),
    Resident(name: '郑婷', age: 27, address: "10-104"),
    Resident(name: '黄勇', age: 21, address: "11-206"),
    Resident(name: '徐霞', age: 26, address: "12-308"),
    Resident(name: '王阳', age: 29, address: "13-105"),
    Resident(name: '李梅', age: 18, address: "14-207"),
    Resident(name: '刘斌', age: 33, address: "15-309"),
    Resident(name: '张丽', age: 32, address: "16-106"),
    Resident(name: '赵飞', age: 20, address: "17-208"),
    Resident(name: '陈杰', age: 25, address: "18-310"),
    Resident(name: '孙娟', age: 30, address: "19-107"),
    Resident(name: '周洁', age: 22, address: "20-209"),
    Resident(name: '郑宇', age: 28, address: "21-311"),
    Resident(name: '黄萍', age: 19, address: "22-108"),
    Resident(name: '徐强', age: 24, address: "23-210"),
    Resident(name: '王芳', age: 31, address: "24-312"),
    Resident(name: '李林', age: 23, address: "25-109"),
    Resident(name: '刘婷', age: 27, address: "26-211"),
    Resident(name: '张勇', age: 21, address: "27-313"),
    Resident(name: '赵霞', age: 26, address: "28-110"),
    Resident(name: '陈阳', age: 29, address: "29-212"),
    Resident(name: '孙梅', age: 18, address: "30-314"),
    Resident(name: '周斌', age: 33, address: "31-111"),
    Resident(name: '郑丽', age: 32, address: "32-213"),
    Resident(name: '黄飞', age: 20, address: "33-315"),

  ];
  List<Resident> searchResults = []; //存储搜索到的信息
  List<Resident> pendingResidents = [
    Resident(name: "张三", age: 25, address: "1-303"), // 待审核的人员信息列表（示例数据）
    Resident(name: "李四", age: 30, address: "6-502"),
    Resident(name: "王五", age: 35, address: "3-102"),
    Resident(name: '李小明', age: 20, address: "4-101"),
    Resident(name: '张小明', age: 20, address: "5-801"),
    Resident(name: '刘小明', age: 20, address: "5-701"),
    Resident(name: '陈小明', age: 20, address: "5-601"),
    Resident(name: '赵小明', age: 20, address: "4-101"),
    Resident(name: '孙小明', age: 20, address: "5-101"),
    Resident(name: '周小明', age: 20, address: "3-101"),
    Resident(name: '钱小明', age: 20, address: "8-101"),
    Resident(name: '吴小明', age: 20, address: "9-101"),
  ];

  bool isSearching = false;

  void _searchResidents(String searchTerm) {
    setState(() {
      searchResults = residents
          .where((resident) =>
              resident.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
      isSearching = true;
    });
  }

  void _updateResident(
      Resident resident, String newName, int newAge, String newAddress) {
    setState(() {
      resident.name = newName;
      resident.age = newAge;
      resident.address = newAddress;
    });
  }

  void _showApprovalDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("待审核人员信息"),
            content: ListView.builder(
                shrinkWrap: true,
                itemCount: pendingResidents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(pendingResidents[index].name),
                        subtitle: Text(
                            '年龄:${pendingResidents[index].age},住址：${pendingResidents[index].address}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
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
                              onPressed: () {
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
                      ),
                      Divider(),
                    ],
                  );
                }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("智慧社区-居民管理"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: _searchResidents,
              decoration: InputDecoration(
                  hintText: '输入居民姓名进行搜索', suffixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount:
                      isSearching ? searchResults.length : residents.length,
                  itemBuilder: (BuildContext context, int index) {
                    final resident =
                        isSearching ? searchResults[index] : residents[index];
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(resident.name),
                          subtitle:
                              Text('年龄：${resident.age} 住址：${resident.address}'),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                TextEditingController nameController =
                                    TextEditingController(text: resident.name);
                                TextEditingController ageController =
                                    TextEditingController(
                                        text: resident.age.toString());
                                TextEditingController addressController =
                                    TextEditingController(
                                        text: resident.address);

                                return AlertDialog(
                                  title: Text("修改居民信息"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: nameController,
                                        decoration:
                                            InputDecoration(labelText: "姓名"),
                                      ),
                                      TextField(
                                        controller: ageController,
                                        keyboardType: TextInputType.number,
                                        decoration:
                                            InputDecoration(labelText: "年龄"),
                                      ),
                                      TextField(
                                        controller: addressController,
                                        decoration:
                                            InputDecoration(labelText: "住址"),
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
                                        int newAge =
                                            int.tryParse(ageController.text) ??
                                                resident.age;
                                        String newAddress =
                                            addressController.text;

                                        // 更新居民信息
                                        _updateResident(resident, newName,
                                            newAge, newAddress);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        Divider()
                      ],
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showApprovalDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Resident {
  String name;
  int age;
  String address;

  Resident({required this.name, required this.age, required this.address});
}

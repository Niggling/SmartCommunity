import 'package:flutter/material.dart';
import '/database_helper.dart';

class HouseManagementPage extends StatefulWidget {
  @override
  _HouseManagementPageState createState() => _HouseManagementPageState();
}

class _HouseManagementPageState extends State<HouseManagementPage> {
  String? selectedCommunity;
  String? selectedBuilding;
  String? selectedUnit;
  String? selectedHouse;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: '确认',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }


  void _bindHouse() async {
    if (selectedCommunity != null &&
        selectedBuilding != null &&
        selectedUnit != null &&
        selectedHouse != null) {
      // 执行房屋绑定逻辑
      print('房屋绑定成功');
      _showSnackBar('申请已发送');

      // 初始化数据库连接
      await DatabaseHelper.instance.openConnection();

      // 发送申请信息给物业端
      int applicationId = await DatabaseHelper.instance.insertApplication(
        '业主姓名',
        selectedCommunity!,
        selectedBuilding!,
        selectedUnit!,
        selectedHouse!,
      );

      print('申请信息插入成功，申请ID为: $applicationId');

      // 关闭数据库连接
      await DatabaseHelper.instance.closeConnection();
    } else {
      print('房屋绑定失败');
    }
  }




  Future<void> sendApplication(
      String community, String building, String unit, String house) async {
    // 构造申请信息
    Map<String, dynamic> applicationData = {
      'owner': '业主姓名',
      'community': community,
      'building': building,
      'unit': unit,
      'house': house,
    };

    // 将申请信息插入数据库
    int applicationId = await DatabaseHelper.instance.insertApplication('业主姓名', selectedCommunity!, selectedBuilding!, selectedUnit!, selectedHouse!);
    print('申请信息插入数据库成功，ID: $applicationId');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('房屋管理'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '选择小区:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: selectedCommunity,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCommunity = newValue;
                });
              },
              items: <String>[
                '小区1',
                '小区2',
                '小区3',
                '小区4',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text(
              '选择楼栋:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: selectedBuilding,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBuilding = newValue;
                });
              },
              items: <String>[
                '楼栋1',
                '楼栋2',
                '楼栋3',
                '楼栋4',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text(
              '选择单元:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: selectedUnit,
              onChanged: (String? newValue) {
                setState(() {
                  selectedUnit = newValue;
                });
              },
              items: <String>[
                '单元1',
                '单元2',
                '单元3',
                '单元4',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text(
              '选择户号:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: selectedHouse,
              onChanged: (String? newValue) {
                setState(() {
                  selectedHouse = newValue;
                });
              },
              items: <String>[
                '户号1',
                '户号2',
                '户号3',
                '户号4',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _bindHouse,
              child: Text('绑定房屋'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HouseManagementPage(),
  ));
}

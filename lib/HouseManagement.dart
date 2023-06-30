import 'package:flutter/material.dart';

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

  void _bindHouse() {
    if (selectedCommunity != null &&
        selectedBuilding != null &&
        selectedUnit != null &&
        selectedHouse != null) {
      print('房屋绑定成功');
      _showSnackBar('申请已发送');
    } else {
      print('房屋绑定失败');
    }
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
                '翡翠湖小区',
                '屯溪路小区',
                '合工大小区',
                '中科大小区',
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
                '1号楼',
                '2号楼',
                '3号楼',
                '4号楼',
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
                '1单元',
                '2单元',
                '3单元',
                '4单元',
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
                '101',
                '102',
                '201',
                '202',
                '301',
                '302',
                '401',
                '402',
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

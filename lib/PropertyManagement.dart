import 'package:flutter/material.dart';

class PropertyManagementPage extends StatefulWidget {
  @override
  _PropertyManagementPageState createState() => _PropertyManagementPageState();
}

class _PropertyManagementPageState extends State<PropertyManagementPage> {
  List<Map<String, dynamic>> applicationList = [
    {
      'id': 1,
      'owner': '张三',
      'community': '小区A',
      'building': '1栋',
      'unit': '1单元',
      'house': '101',
    },
    {
      'id': 2,
      'owner': '李四',
      'community': '小区B',
      'building': '2栋',
      'unit': '2单元',
      'house': '202',
    },
    {
      'id': 3,
      'owner': '王五',
      'community': '小区C',
      'building': '3栋',
      'unit': '3单元',
      'house': '303',
    },
    // 更多的假数据...
    {
      'id': 4,
      'owner': '赵六',
      'community': '小区D',
      'building': '4栋',
      'unit': '4单元',
      'house': '404',
    },
    {
      'id': 5,
      'owner': '钱七',
      'community': '小区E',
      'building': '5栋',
      'unit': '5单元',
      'house': '505',
    },
  ]; // 物业申请列表

  void _handleApplication(int applicationId, bool approved) {
    // 处理申请，根据approved确定是否同意
    if (approved) {
      print('同意申请');
    } else {
      print('不同意申请');
    }

    setState(() {
      applicationList.removeWhere((application) => application['id'] == applicationId);
    });

    // TODO: 更新数据库中的申请状态
  }

  Widget _buildApplicationItem(Map<String, dynamic> application) {
    final applicationId = application['id'];
    final owner = application['owner'];
    final community = application['community'];
    final building = application['building'];
    final unit = application['unit'];
    final house = application['house'];

    return ListTile(
      title: Text('$owner - $community - $building - $unit - $house'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => _handleApplication(applicationId, true),
            child: Text('同意'),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => _handleApplication(applicationId, false),
            child: Text('不同意'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('物业管理'),
      ),
      body: ListView.builder(
        itemCount: applicationList.length,
        itemBuilder: (context, index) {
          return _buildApplicationItem(applicationList[index]);
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PropertyManagementPage(),
  ));
}

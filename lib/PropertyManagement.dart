import 'package:flutter/material.dart';
import '/database_helper.dart';

class PropertyManagementPage extends StatefulWidget {
  @override
  _PropertyManagementPageState createState() => _PropertyManagementPageState();
}

class _PropertyManagementPageState extends State<PropertyManagementPage> {
  List<Map<String, dynamic>> applicationList = []; // 物业申请列表

  @override
  void initState() {
    super.initState();
    _loadApplications();
  }

  void _loadApplications() async {
    final dbHelper = DatabaseHelper.instance;
    final list = await dbHelper.getApplicationList();
    setState(() {
      applicationList = list;
    });
  }


  void _handleApplication(int applicationId, bool approved) {
    // 处理申请，根据approved确定是否同意
    if (approved) {
      print('同意申请');
    } else {
      print('不同意申请');
    }

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

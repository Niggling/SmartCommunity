import 'package:flutter/material.dart';

class VehicleApprovalPage extends StatefulWidget {
  @override
  _VehicleApprovalPageState createState() => _VehicleApprovalPageState();
}

class _VehicleApprovalPageState extends State<VehicleApprovalPage> with SingleTickerProviderStateMixin {
  List<String> pendingApprovals = [
    '审核单号100002023070601',
    '审核单号100002023070602',
    '审核单号100002023070603',
    '审核单号100002023070605',
    '审核单号100002023070607',
    '审核单号100002023070608',
    '审核单号100002023070609',
    '审核单号100002023070610',

  ];
  List<String> approvedApprovals = [
    '审核单号100002023070604',
    '审核单号100002023070606',
  ];
  List<String> rejectedApprovals = [
    '审核单号100002023070611',
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 设置选项卡的数量为2
  }

  @override
  void dispose() {
    _tabController.dispose(); // 释放TabController资源
    super.dispose();
  }

  void approveVehicle(String approval) {
    // 处理车辆审核单的批准通过操作
    setState(() {
      pendingApprovals.remove(approval);
      approvedApprovals.add(approval);
    });
  }

  void rejectVehicle(String approval) {
    // 处理车辆审核单的不通过操作
    setState(() {
      pendingApprovals.remove(approval);
      rejectedApprovals.add(approval);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('车辆审核'),
        bottom: TabBar(
          controller: _tabController, // 将TabController传递给TabBar
          tabs: [
            Tab(text: '待处理'),
            Tab(text: '已处理'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController, // 将TabController传递给TabBarView
        children: [
          ListView.builder(
            itemCount: pendingApprovals.length,
            itemBuilder: (context, index) {
              final approval = pendingApprovals[index];
              return ExpansionTile(
                title: Text(approval),
                children: [
                  // 这里可以添加审核单的具体信息
                  Text('$approval 的详细信息'),
                  Text('业主ID为 徐尚'),
                  Text('车牌号为 晋ANQ631'),
                  Text('申请车位号为 B-3'),
                ],
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check),
                      //帮我把这个check的图标换成绿色的
                      color: Colors.green,
                      onPressed: () => approveVehicle(approval),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      //帮我把这个close的图标换成红色的
                      color: Colors.red,
                      onPressed: () => rejectVehicle(approval),
                    ),
                  ],
                ),
              );
            },
          ),
          ListView(
            children: [
              ...approvedApprovals.map((approval) => ListTile(
                title: Text(approval),
                trailing: Icon(Icons.check),
                //帮我把这个check的图标换成绿色的
                iconColor: Colors.green,
              )),
              ...rejectedApprovals.map((approval) => ListTile(
                title: Text(approval),
                trailing: Icon(Icons.close),
                //帮我把这个close的图标换成红色的
                iconColor: Colors.red,
              )),
            ],
          ),
        ],
      ),
    );
  }
}

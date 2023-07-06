import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: VotingPage(),
  ));
}

class VotingPage extends StatefulWidget {
  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  List<VotingItem> _votingItems = [
    VotingItem(
      project: '公共照明',
      reason: '公共照明费用',
      cost: '1000元',
      time: '2023-07-01',
    ),
    VotingItem(
      project: '花园维护',
      reason: '花园维护费用',
      cost: '2000元',
      time: '2023-07-05',
    ),
    VotingItem(
      project: '安保系统',
      reason: '安保系统费用',
      cost: '8000元',
      time: '2023-07-06',
    ),
    // 添加更多投票项目...
  ];

  // 控制弹窗中文本输入框的控制器
  TextEditingController _projectController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _costController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _projectController.dispose();
    _reasonController.dispose();
    _costController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('添加支出'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _projectController,
                decoration: InputDecoration(
                  labelText: '支出项目',
                ),
              ),
              TextField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: '支出缘由',
                ),
              ),
              TextField(
                controller: _costController,
                decoration: InputDecoration(
                  labelText: '支出费用',
                ),
              ),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: '支出时间',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                // 创建新的投票项目
                VotingItem newItem = VotingItem(
                  project: _projectController.text,
                  reason: _reasonController.text,
                  cost: _costController.text,
                  time: _timeController.text,
                );
                setState(() {
                  _votingItems.add(newItem);
                });
                // 清空输入框内容
                _projectController.clear();
                _reasonController.clear();
                _costController.clear();
                _timeController.clear();
                Navigator.of(context).pop();
              },
              child: Text('确定'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('投票列表'),
      ),
      body: ListView.builder(
        itemCount: _votingItems.length,
        itemBuilder: (BuildContext context, int index) {
          VotingItem item = _votingItems[index];
          return ListTile(
            title: Text(item.project),
            subtitle: Text(item.reason),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('费用: ${item.cost}'),
                Text('时间: ${item.time}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VotingDetailsPage(item: item),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

class VotingItem {
  final String project;
  final String reason;
  final String cost;
  final String time;

  VotingItem({
    required this.project,
    required this.reason,
    required this.cost,
    required this.time,
  });
}

class VotingDetailsPage extends StatefulWidget {
  final VotingItem item;

  VotingDetailsPage({required this.item});

  @override
  _VotingDetailsPageState createState() => _VotingDetailsPageState();
}

class _VotingDetailsPageState extends State<VotingDetailsPage> {
  bool _voted = false;
  bool _voteResult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('投票详情'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('项目: ${widget.item.project}'),
            SizedBox(height: 8.0),
            Text('支出缘由: ${widget.item.reason}'),
            SizedBox(height: 8.0),
            Text('费用: ${widget.item.cost}'),
            SizedBox(height: 8.0),
            Text('时间: ${widget.item.time}'),
            SizedBox(height: 16.0),
            Text('投票状态: ${_voted ? '已投票' : '投票中'}'),
            SizedBox(height: 8.0),
            Text('投票结果: ${_voteResult ? '通过' : '未通过'}'),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

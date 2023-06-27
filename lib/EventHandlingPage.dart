import 'package:flutter/material.dart';

class EventHandlingPage extends StatefulWidget {
  @override
  _EventHandlingPageState createState() => _EventHandlingPageState();
}

class _EventHandlingPageState extends State<EventHandlingPage> {
  List<ReportedProblem> reportedProblems = [
    ReportedProblem(
      id: 1,
      owner: '张三',
      property: '101号单元',
      description: '浴室的水龙头漏水',
      status: '待处理',
    ),
    ReportedProblem(
      id: 2,
      owner: '李四',
      property: '202号单元',
      description: '门把手损坏',
      status: '处理中',
    ),
    // 添加更多已报告的问题
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('事件处理'),
      ),
      body: ListView.builder(
        itemCount: reportedProblems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('问题描述：${reportedProblems[index].description}'),
            subtitle: Text('业主：${reportedProblems[index].owner}\n'
                '房产：${reportedProblems[index].property}\n'
                '状态：${reportedProblems[index].status}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProblemDetailsPage(
                    problem: reportedProblems[index],
                    onUpdateStatus: (newStatus) {
                      setState(() {
                        reportedProblems[index].status = newStatus;
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProblemDetailsPage extends StatelessWidget {
  final ReportedProblem problem;
  final Function(String) onUpdateStatus;

  ProblemDetailsPage({required this.problem, required this.onUpdateStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('问题详情'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '问题描述：',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              problem.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '业主：${problem.owner}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              '房产：${problem.property}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    onUpdateStatus('已处理');
                  },
                  child: Text('已处理'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    onUpdateStatus('上报');
                  },
                  child: Text('上报'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    onUpdateStatus('忽略');
                  },
                  child: Text('忽略'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              '处理状态：${problem.status}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportedProblem {
  final int id;
  final String owner;
  final String property;
  final String description;
  String status;

  ReportedProblem({
    required this.id,
    required this.owner,
    required this.property,
    required this.description,
    required this.status,
  });
}

void main() {
  runApp(MaterialApp(
    home: EventHandlingPage(),
  ));
}

import 'package:flutter/material.dart';

class EventHandlingPage extends StatefulWidget {
  @override
  _EventHandlingPageState createState() => _EventHandlingPageState();
}

class _EventHandlingPageState extends State<EventHandlingPage> {
  List<Map<String, dynamic>> eventList = [
    {
      'id': 1,
      'description': '房屋出现水管漏水问题',
      'status': '未处理',
      'owner': '业主1',
      'house': '房屋1',
    },
    {
      'id': 2,
      'description': '房屋电路故障',
      'status': '未处理',
      'owner': '业主2',
      'house': '房屋2',
    },
    {
      'id': 3,
      'description': '房屋门窗损坏',
      'status': '未处理',
      'owner': '业主3',
      'house': '房屋3',
    },
    {
      'id': 4,
      'description': '房屋空调故障',
      'status': '未处理',
      'owner': '业主4',
      'house': '房屋4',
    },
    {
      'id': 5,
      'description': '房屋卫生问题',
      'status': '未处理',
      'owner': '业主5',
      'house': '房屋5',
    },
    {
      'id': 6,
      'description': '房屋燃气泄漏',
      'status': '未处理',
      'owner': '业主6',
      'house': '房屋6',
    },
  ]; // 事件列表

  String searchText = ''; // 搜索文本

  void _updateEventStatus(int eventId, String newStatus) {
    setState(() {
      final event = eventList.firstWhere((event) => event['id'] == eventId);
      event['status'] = newStatus;
    });
  }

  void _transferToHigherLevel(int eventId) {
    setState(() {
      final event = eventList.firstWhere((event) => event['id'] == eventId);
      event['status'] = '上报到上层级';
    });
  }

  List<Map<String, dynamic>> _filterEvents() {
    List<Map<String, dynamic>> filteredList = eventList;

    if (searchText.isNotEmpty) {
      filteredList = filteredList.where((event) {
        final description = event['description'].toString().toLowerCase();
        return description.contains(searchText.toLowerCase());
      }).toList();
    }

    filteredList.sort((a, b) {
      final aStatus = a['status'];
      final bStatus = b['status'];
      final isADone = aStatus == '已处理' || aStatus == '上报到上层级';
      final isBDone = bStatus == '已处理' || bStatus == '上报到上层级';

      if (isADone && !isBDone) {
        return 1;
      } else if (!isADone && isBDone) {
        return -1;
      } else {
        return 0;
      }
    });

    return filteredList;
  }

  Widget _buildEventItem(Map<String, dynamic> event) {
    final eventId = event['id'];
    final description = event['description'];
    final status = event['status'];
    final owner = event['owner'];
    final house = event['house'];

    final isPending = status == '未处理';

    return Column(
      children: [
        ListTile(
          title: Text('问题: $description'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('业主: $owner'),
              Text('房屋: $house'),
              Text(
                '处理状态: ',
                style: TextStyle(
                  color: isPending ? Colors.red : null,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: isPending ? Colors.red : null,
                  fontWeight: isPending ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => _updateEventStatus(eventId, '已处理'),
                child: Text('已处理'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _transferToHigherLevel(eventId),
                child: Text('上报'),
              ),
            ],
          ),
        ),
        Container(
          height: 1.0,
          margin: EdgeInsets.symmetric(horizontal: 16.0),  // 在这里添加了 margin
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.transparent,
                Colors.grey,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    final filteredEvents = _filterEvents();

    return Scaffold(
      appBar: AppBar(
        title: Text('事件处理'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: '搜索',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                return _buildEventItem(filteredEvents[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EventHandlingPage(),
  ));
}

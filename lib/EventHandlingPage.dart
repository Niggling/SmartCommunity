import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
    ),
    home: EventHandlingPage(),
  ));
}

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
    {
      'id': 7,
      'description': '房屋地板破损',
      'status': '未处理',
      'owner': '业主7',
      'house': '房屋7',
    },
    {
      'id': 8,
      'description': '房屋墙面渗水',
      'status': '未处理',
      'owner': '业主8',
      'house': '房屋8',
    },
    {
      'id': 9,
      'description': '房屋天花板漏水',
      'status': '未处理',
      'owner': '业主9',
      'house': '房屋9',
    },
    {
      'id': 10,
      'description': '房屋马桶堵塞',
      'status': '未处理',
      'owner': '业主10',
      'house': '房屋10',
    },
    {
      'id': 11,
      'description': '房屋电梯故障',
      'status': '未处理',
      'owner': '业主11',
      'house': '房屋11',
    },
    {
      'id': 12,
      'description': '房屋噪音扰民',
      'status': '未处理',
      'owner': '业主12',
      'house': '房屋12',
    },
    {
      'id': 13,
      'description': '房屋电器损坏',
      'status': '未处理',
      'owner': '业主13',
      'house': '房屋13',
    },
    {
      'id': 14,
      'description': '房屋烟雾报警器失灵',
      'status': '未处理',
      'owner': '业主14',
      'house': '房屋14',
    },
    {
      'id': 15,
      'description': '房屋下水道堵塞',
      'status': '未处理',
      'owner': '业主15',
      'house': '房屋15',
    },
    {
      'id': 16,
      'description': '房屋窗户玻璃破碎',
      'status': '未处理',
      'owner': '业主16',
      'house': '房屋16',
    },
    {
      'id': 17,
      'description': '房屋暖气不热',
      'status': '未处理',
      'owner': '业主17',
      'house': '房屋17',
    },
    {
      'id': 18,
      'description': '房屋墙壁开裂',
      'status': '未处理',
      'owner': '业主18',
      'house': '房屋18',
    },
    {
      'id': 19,
      'description': '房屋天窗漏水',
      'status': '未处理',
      'owner': '业主19',
      'house': '房屋19',
    },
    {
      'id': 20,
      'description': '房屋垃圾处理问题',
      'status': '未处理',
      'owner': '业主20',
      'house': '房屋20',
    }
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

    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Text(
                '问题: $description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
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
                    style: ElevatedButton.styleFrom(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _transferToHigherLevel(eventId),
                    child: Text('上报'),
                    style: ElevatedButton.styleFrom(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0),
                    Colors.grey,
                    Color.fromRGBO(0, 0, 0, 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredEvents = _filterEvents();

    return Scaffold(
      appBar: AppBar(
        title: Text('事件处理'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
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
      ),
    );
  }
}

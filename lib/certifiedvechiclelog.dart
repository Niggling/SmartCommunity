import 'package:flutter/material.dart';

class CertifiedVehicleLog extends StatefulWidget {
  @override
  _CertifiedVehicleLogState createState() => _CertifiedVehicleLogState();
}

class _CertifiedVehicleLogState extends State<CertifiedVehicleLog> {
  String queryType = 'ownerID';
  String queryValue = '';
  String queryResult = '';

  void performQuery(String queryType, String queryValue) {
    // 在这里编写查询逻辑，根据查询类型和查询值执行相应的查询操作，并将结果赋值给queryResult

    // 示例代码，根据不同的查询类型执行不同的查询操作
    if (queryType == 'ownerID') {
      // 通过业主ID查找车牌信息、车位信息和车辆信息
      queryResult = '查询结果：通过业主ID查询到的车牌信息、车位信息和车辆信息';
    } else if (queryType == 'licensePlate') {
      // 通过车牌信息查找业主ID、车位信息和车辆信息
      queryResult = '查询结果：通过车牌信息查询到的业主ID、车位信息和车辆信息';
    } else if (queryType == 'parkingInfo') {
      // 通过车位信息查找业主ID、车牌信息和车辆信息
      queryResult = '查询结果：通过车位信息查询到的业主ID、车牌信息和车辆信息';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('查询示例'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButton<String>(
                value: queryType,
                onChanged: (String? newValue) {
                  setState(() {
                    queryType = newValue!;
                  });
                },
                items: <String>[
                  'ownerID',
                  'licensePlate',
                  'parkingInfo',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  queryValue = value;
                },
                decoration: InputDecoration(
                  labelText: '请输入对应信息进行查询',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 执行查询
                  performQuery(queryType, queryValue);
                },
                child: Text('执行查询'),
              ),
              SizedBox(height: 20),
              Text(
                queryResult,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
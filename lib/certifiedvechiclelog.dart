import 'package:flutter/material.dart';

class CertifiedVehicleLog extends StatefulWidget {
  @override
  _CertifiedVehicleLogState createState() => _CertifiedVehicleLogState();
}

class _CertifiedVehicleLogState extends State<CertifiedVehicleLog> {
  String queryType = '业主ID'; // 将英文替换为中文
  String queryValue = '';
  String queryResult = '';

  void performQuery(String queryType, String queryValue) {
    // 在这里编写查询逻辑，根据查询类型和查询值执行相应的查询操作，并将结果赋值给queryResult

    // 示例代码，根据不同的查询类型执行不同的查询操作
    if (queryType == '业主ID') { // 将英文替换为中文
      // 通过业主ID查找车牌信息、车位信息和车辆信息
      queryResult = '查询结果：通过业主ID查询到的车牌信息、车位信息和车辆信息：\n'
          '业主ID：徐尚,车牌号 晋ANQ631,车位号 B-3,车辆：大众朗逸\n'
          '业主ID：徐尚,车牌号 沪ADQ897,车位号 A-3，车辆：宝马s5';
    } else if (queryType == '车牌号') { // 将英文替换为中文
      // 通过车牌信息查找业主ID、车位信息和车辆信息
      queryResult = '查询结果：通过车牌信息查询到的业主ID、车位信息和车辆信息:\n'
          '车牌号 晋ANQ631,业主ID：徐尚,车位号 B-3,车辆：大众朗逸';
    } else if (queryType == '车位信息') { // 将英文替换为中文
      // 通过车位信息查找业主ID、车牌信息和车辆信息
      queryResult = '查询结果：通过车位信息查询到的业主ID、车牌信息和车辆信息:\n'
          '车位号 B-3,车牌号 晋ANQ631,业主ID：徐尚,车辆：大众朗逸';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('查询示例'),
      ),
      body: SingleChildScrollView(
      child:Align(
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
                  '业主ID', // 将英文替换为中文
                  '车牌号', // 将英文替换为中文
                  '车位信息', // 将英文替换为中文
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
        )),
      ),
    );
  }
}

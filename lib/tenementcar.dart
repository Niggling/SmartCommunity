import 'package:flutter/material.dart';
import '/certifiedvechiclelog.dart';
import '/vehicleaudit.dart';



class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('物业端'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                  return CertifiedVehicleLog();
                }));
              },
              child: Text('已认证车辆查询'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return VehicleApprovalPage();
                    }));
              },
              child: Text('车辆审核'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {

  runApp(MaterialApp(
    title: 'Tenement Car',
    home: MyHomePage()
  ));
}
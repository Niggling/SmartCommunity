import 'package:flutter/material.dart';
import '/certifiedvechiclelog.dart';
import '/vehicleaudit.dart';



class MyHomePage extends StatelessWidget {
  Map<String, WidgetBuilder> routes = {
    "certified_vehicle_log":(context) => CertifiedVehicleLog(),
    "tenement_car":(context) => MyHomePage(),
    "vehicle_audit":(context) => VehicleApprovalPage(),
  };
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
                Navigator.pushNamed(context, "certified_vehicle_log");
              },
              child: Text('已认证车辆查询'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "vehicle_audit");
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
    initialRoute: "tenement_car",
    routes:{
      "certified_vehicle_log":(context) => CertifiedVehicleLog(),
      "tenement_car":(context) => MyHomePage(),
      "vehicle_audit":(context) => VehicleApprovalPage(),
    } ,
  ));
}
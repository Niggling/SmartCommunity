import 'package:flutter/material.dart';

class Vehicle {
  String licensePlate;

  Vehicle(this.licensePlate);
}

class ParkingSpace {
  int spaceNumber;

  ParkingSpace(this.spaceNumber);
}

class House {
  String houseNumber;

  House(this.houseNumber);
}

class VehicleManagementPage extends StatefulWidget {
  @override
  _VehicleManagementPageState createState() => _VehicleManagementPageState();
}

class _VehicleManagementPageState extends State<VehicleManagementPage> {
  List<Vehicle> vehicles = [];
  List<ParkingSpace> parkingSpaces = [];
  List<House> houses = [];

  List<House> selectedHouses = [];

  @override
  void initState() {
    super.initState();
    // 初始化车辆、车位、房屋数据
    vehicles = [
      Vehicle("晋ANQ631")
    ];
    parkingSpaces = [
      ParkingSpace(1),
      ParkingSpace(2),
    ];
    houses = [
      House('A-101'),
      House('B-202'),
      House('C-303'),
    ];
  }

  void addVehicle() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController _licenseplate = TextEditingController();
          return AlertDialog(
            title: Text('添加车辆'),
            content: SingleChildScrollView(
              child: TextField(
                controller: _licenseplate,
                autofocus: true,
                decoration: const InputDecoration(
                    labelText: "添加车辆",
                    hintText: "车牌号",
                    prefixIcon: Icon(Icons.air)
                ),

              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    vehicles.add(Vehicle(_licenseplate.text));
                  });
                  Navigator.of(context).pop();
                },
                child: Text('确认'),
              ),
            ],
          );
        }
    );
  }

  void bindVehicleToHouses(Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('选择绑定房屋'),
          content: SingleChildScrollView(
            child: Column(
              children: houses
                  .map(
                    (house) =>
                    CheckboxListTile(
                      title: Text(house.houseNumber),
                      value: selectedHouses.contains(house),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedHouses.add(house);
                          } else {
                            selectedHouses.remove(house);
                          }
                        });
                      },
                    ),
              )
                  .toList(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // 将选中的房屋与车辆进行绑定
                // 可根据业务需求进行后续处理，比如保存绑定关系到数据库等
                Navigator.of(context).pop();
              },
              child: Text('确认'),
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
        title: Text('车辆管理'),
      ),
      body: ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (BuildContext context, int index) {

              Vehicle vehicle = vehicles[index];
              return ListTile(
                title: Text(vehicle.licensePlate),
                subtitle: Text('绑定房屋：${selectedHouses.length}'),
                trailing: IconButton(
                  icon: Icon(Icons.link),
                  onPressed: () {
                    bindVehicleToHouses(vehicle);
                  },
                ),
              );
            }

        ),
      floatingActionButton: FloatingActionButton( //悬浮按钮
          child: const Icon(Icons.add),
          onPressed:(){addVehicle();}
      ),

    );
  }
}


void main() {
  runApp(MaterialApp(
    home: VehicleManagementPage(),
  ));
}


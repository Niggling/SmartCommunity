import 'package:flutter/material.dart';

class Vehicle {
  String licensePlate;
  List<House> selectedHouses; // 记录每辆车的绑定房屋信息
  List<ParkingSpace> selectedParkingSpaces; // 记录每辆车的绑定车位信息

  Vehicle(this.licensePlate, this.selectedHouses, this.selectedParkingSpaces);
}

class ParkingSpace {
  String spaceNumber;

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

  TextEditingController houseController = TextEditingController();
  TextEditingController parkingSpaceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 初始化车辆、车位、房屋数据
    vehicles = [
      Vehicle("晋ANQ631", [], []),
    ];
    parkingSpaces = [
      ParkingSpace("A-1"),
      ParkingSpace("A-2"),
    ];
    houses = [];
  }

  void addVehicle() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController licensePlateController = TextEditingController();
        return AlertDialog(
          title: Text('添加车辆'),
          content: SingleChildScrollView(
            child: TextField(
              controller: licensePlateController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "添加车辆",
                hintText: "车牌号",
                prefixIcon: Icon(Icons.air),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  vehicles.add(Vehicle(licensePlateController.text, [], [])); // 每辆车单独拥有绑定房屋和车位信息的空列表
                });
                Navigator.of(context).pop();
              },
              child: Text('确认'),
            ),
          ],
        );
      },
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
              children: [
                TextField(
                  controller: houseController,
                  decoration: InputDecoration(
                    labelText: '输入房屋',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if(houseController.text.isNotEmpty)
                        {
                      House house = House(houseController.text);
                      vehicle.selectedHouses.add(house); // 将输入的房屋添加到当前车辆的绑定房屋列表中
                      houseController.clear(); // 清空输入框
                        }
                    });
                  },
                  child: Text('添加房屋'),
                ),
                SizedBox(height: 10),
                Column(
                  children: vehicle.selectedHouses
                      .map(
                        (house) => ListTile(
                      title: Text(house.houseNumber),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            vehicle.selectedHouses.remove(house); // 从当前车辆的绑定房屋列表中移除选中的房屋
                          });
                        },
                      ),
                    ),
                  )
                      .toList(),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('选择绑定车位'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              controller: parkingSpaceController,
                              decoration: InputDecoration(
                                labelText: '输入车位',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  ParkingSpace space =
                                  ParkingSpace(parkingSpaceController.text);
                                  vehicle.selectedParkingSpaces.add(space); // 将输入的车位添加到当前车辆的绑定车位列表中
                                  parkingSpaceController.clear(); // 清空输入框
                                });
                              },
                              child: Text('添加车位'),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: vehicle.selectedParkingSpaces
                                  .map(
                                    (space) => ListTile(
                                  title: Text('车位${space.spaceNumber}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        vehicle.selectedParkingSpaces
                                            .remove(space); // 从当前车辆的绑定车位列表中移除选中的车位
                                      });
                                    },
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            final snackBar = SnackBar(
                              content: Text('车辆绑定信息已上传至物业端审核。'),
                              duration: Duration(seconds: 3),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            Navigator.of(context).pop();
                          },
                          child: Text('上传审核'),
                        ),
                      ],
                    );
                  },
                );
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (BuildContext context, int index) {
                Vehicle vehicle = vehicles[index];
                return ListTile(
                  title: Text(vehicle.licensePlate),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('绑定房屋：'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: vehicle.selectedHouses.map((house) {
                          return Text(house.houseNumber);
                        }).toList(),
                      ),
                      SizedBox(height: 4),
                      Text('绑定车位：'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: vehicle.selectedParkingSpaces.map((space) {
                          return Text('车位${space.spaceNumber}');
                        }).toList(),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.link),
                    onPressed: () {
                      bindVehicleToHouses(vehicle);
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(58.0),
            child: Text(
              '点击《添加》按钮或是《垃圾桶》按钮后，前台数据已发生变更，请不要继续反复点击这些按钮，请点击确认以进入下一步。',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addVehicle();
        },
      ),
    );
  }
}

  void main() {
  runApp(
    MaterialApp(
      home: VehicleManagementPage(),
    ),
  );
}

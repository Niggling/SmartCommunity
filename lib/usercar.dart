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
      ParkingSpace("B-1"),
      ParkingSpace("B-2"),
      ParkingSpace("C-1"),
      ParkingSpace("C-2"),
      ParkingSpace("D-1"),
      ParkingSpace("D-2"),
      ParkingSpace("E-1"),
      ParkingSpace("E-2"),
      ParkingSpace("F-1"),
      ParkingSpace("F-2"),
    ];
    houses = [
      House("22栋401"),
      House("33栋102"),
      House("44栋201"),
      House("55栋301"),
      House("66栋502"),
      House("77栋203"),
      House("88栋404"),
      House("99栋101"),
      House("110栋501"),
      House("121栋202"),
    ];
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
                DropdownButtonFormField<House>(
                  decoration: InputDecoration(
                    labelText: '选择房屋',
                  ),
                  value: null,
                  onChanged: (House? selectedSpace) {
                    setState(() {
                      if (selectedSpace != null) {
                        vehicle.selectedHouses.add(selectedSpace); // 将选中的车位添加到当前车辆的绑定车位列表中
                      }
                    });
                  },
                  items: houses.map<DropdownMenuItem<House>>(
                        (House space) {
                      return DropdownMenuItem<House>(
                        value: space,
                        child: Text('房屋${space.houseNumber}'),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(height: 10),
                Column(
                  children: vehicle.selectedHouses
                      .map(
                        (space) => ListTile(
                      title: Text('房屋${space.houseNumber}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            vehicle.selectedHouses.remove(space); // 从当前房屋的绑定房屋列表中移除选中的房屋
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
                            DropdownButtonFormField<ParkingSpace>(
                              decoration: InputDecoration(
                                labelText: '选择车位',
                              ),
                              value: null,
                              onChanged: (ParkingSpace? selectedSpace) {
                                setState(() {
                                  if (selectedSpace != null) {
                                    vehicle.selectedParkingSpaces.add(selectedSpace); // 将选中的车位添加到当前车辆的绑定车位列表中
                                  }
                                });
                              },
                              items: parkingSpaces.map<DropdownMenuItem<ParkingSpace>>(
                                    (ParkingSpace space) {
                                  return DropdownMenuItem<ParkingSpace>(
                                    value: space,
                                    child: Text('车位${space.spaceNumber}'),
                                  );
                                },
                              ).toList(),
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
                                        vehicle.selectedParkingSpaces.remove(space); // 从当前车辆的绑定车位列表中移除选中的车位
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
                          },
                          child: Text('上报审核'),
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
      backgroundColor: Colors.grey[100], // 设置背景色为灰色
      appBar: AppBar(
        title: Text('车辆管理'),
      ),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (BuildContext context, int index) {
          Vehicle vehicle = vehicles[index];
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: ListTile(
              title: Text(vehicle.licensePlate),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text('绑定房屋:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: vehicle.selectedHouses.map((house) {
                      return Text('房屋${house.houseNumber}');
                    }).toList(),
                  ),
                  SizedBox(height: 8),
                  Text('绑定车位:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
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
            ),
          );
        },
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

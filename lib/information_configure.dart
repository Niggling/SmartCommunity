import 'package:flutter/material.dart';

class CommunityInfoPage extends StatefulWidget {
  @override
  _CommunityInfoPageState createState() => _CommunityInfoPageState();
}

class _CommunityInfoPageState extends State<CommunityInfoPage> {
  List<String> buildings = [];
  List<String> units = [];
  List<String> houses = [];
  List<String> parkingSpaces = [];

  TextEditingController buildingController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController parkingSpaceController = TextEditingController();

  TextEditingController importDataController = TextEditingController();

  @override
  void dispose() {
    buildingController.dispose();
    unitController.dispose();
    houseController.dispose();
    parkingSpaceController.dispose();
    importDataController.dispose();
    super.dispose();
  }

  void addInfo() {
    setState(() {
      String building = buildingController.text.trim();
      String unit = unitController.text.trim();
      String house = houseController.text.trim();
      String parkingSpace = parkingSpaceController.text.trim();

      // Add items to the corresponding lists
      buildings.add(building);
      units.add(unit);
      houses.add(house);
      parkingSpaces.add(parkingSpace);

      // Clear input fields
      buildingController.clear();
      unitController.clear();
      houseController.clear();
      parkingSpaceController.clear();
    });
  }

  void importData() {
    setState(() {
      String data = importDataController.text;
      // Split imported data into lines
      List<String> lines = data.split('\n');

      // Iterate over lines and parse each item
      for (String line in lines) {
        // Split line into fields
        List<String> fields = line.split(',');

        // Check the number of fields
        if (fields.length == 4) {
          String building = fields[0].trim();
          String unit = fields[1].trim();
          String house = fields[2].trim();
          String parkingSpace = fields[3].trim();

          // Add items to the corresponding lists
          buildings.add(building);
          units.add(unit);
          houses.add(house);
          parkingSpaces.add(parkingSpace);
        }
      }

      importDataController.clear();
    });
  }

  void exportData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('填写模板信息'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: buildingController,
                decoration: InputDecoration(
                  labelText: '楼栋',
                ),
              ),
              TextFormField(
                controller: unitController,
                decoration: InputDecoration(
                  labelText: '单元',
                ),
              ),
              TextFormField(
                controller: houseController,
                decoration: InputDecoration(
                  labelText: '房屋',
                ),
              ),
              TextFormField(
                controller: parkingSpaceController,
                decoration: InputDecoration(
                  labelText: '车位',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  String building = buildingController.text.trim();
                  String unit = unitController.text.trim();
                  String house = houseController.text.trim();
                  String parkingSpace = parkingSpaceController.text.trim();

                  // Add 10 items with the specified information
                  for (int i = 0; i < 10; i++) {
                    buildings.add(building);
                    units.add(unit);
                    houses.add(house);
                    parkingSpaces.add(parkingSpace);
                  }

                  buildingController.clear();
                  unitController.clear();
                  houseController.clear();
                  parkingSpaceController.clear();
                });

                Navigator.pop(context);
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
        title: Text('小区信息'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '添加小区信息:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: buildingController,
                decoration: InputDecoration(
                  labelText: '楼栋',
                ),
              ),
              TextFormField(
                controller: unitController,
                decoration: InputDecoration(
                  labelText: '单元',
                ),
              ),
              TextFormField(
                controller: houseController,
                decoration: InputDecoration(
                  labelText: '房屋',
                ),
              ),
              TextFormField(
                controller: parkingSpaceController,
                decoration: InputDecoration(
                  labelText: '车位',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: addInfo,
                    child: Text('添加'),
                  ),
                  ElevatedButton(
                    onPressed: exportData,
                    child: Text('批量导入'),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                '小区信息:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: buildings.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('楼栋: ${buildings[index]}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('单元: ${units[index]}'),
                        Text('房屋: ${houses[index]}'),
                        Text('车位: ${parkingSpaces[index]}'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CommunityInfoPage(),
  ));
}
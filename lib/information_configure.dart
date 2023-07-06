import 'package:flutter/material.dart';

class Community {
  String building;
  String unit;
  String house;
  String parkingSpace;

  late TextEditingController buildingController;
  late TextEditingController unitController;
  late TextEditingController houseController;
  late TextEditingController parkingSpaceController;

  Community({
    required this.building,
    required this.unit,
    required this.house,
    required this.parkingSpace,
  }) {
    buildingController = TextEditingController(text: building);
    unitController = TextEditingController(text: unit);
    houseController = TextEditingController(text: house);
    parkingSpaceController = TextEditingController(text: parkingSpace);
  }
}

class CommunityInfoPage extends StatefulWidget {
  @override
  _CommunityInfoPageState createState() => _CommunityInfoPageState();
}

class _CommunityInfoPageState extends State<CommunityInfoPage> {
  List<Community> communities = [];
  Community? selectedCommunity;

  TextEditingController importDataController = TextEditingController();

  @override
  void dispose() {
    for (var community in communities) {
      community.buildingController.dispose();
      community.unitController.dispose();
      community.houseController.dispose();
      community.parkingSpaceController.dispose();
    }
    importDataController.dispose();
    super.dispose();
  }

  void addInfo() {
    setState(() {
      Community community = Community(
        building: '',
        unit: '',
        house: '',
        parkingSpace: '',
      );

      communities.add(community);
    });
  }

  void importData() {
    setState(() {
      String data = importDataController.text;
      List<String> lines = data.split('\n');

      for (String line in lines) {
        List<String> fields = line.split(',');

        if (fields.length == 4) {
          Community community = Community(
            building: fields[0].trim(),
            unit: fields[1].trim(),
            house: fields[2].trim(),
            parkingSpace: fields[3].trim(),
          );

          communities.add(community);
        }
      }

      importDataController.clear();
    });
  }

  void exportData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Community community = Community(
          building: '',
          unit: '',
          house: '',
          parkingSpace: '',
        );

        return AlertDialog(
          title: Text('填写模板信息'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: community.buildingController,
                decoration: InputDecoration(
                  labelText: '楼栋',
                ),
              ),
              TextFormField(
                controller: community.unitController,
                decoration: InputDecoration(
                  labelText: '单元',
                ),
              ),
              TextFormField(
                controller: community.houseController,
                decoration: InputDecoration(
                  labelText: '房屋',
                ),
              ),
              TextFormField(
                controller: community.parkingSpaceController,
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
                  community.building = community.buildingController.text.trim();
                  community.unit = community.unitController.text.trim();
                  community.house = community.houseController.text.trim();
                  community.parkingSpace = community.parkingSpaceController.text.trim();

                  // Add 10 items with the specified information
                  for (int i = 0; i < 10; i++) {
                    communities.add(
                      Community(
                        building: community.building,
                        unit: community.unit,
                        house: community.house,
                        parkingSpace: community.parkingSpace,
                      ),
                    );
                  }

                  community.buildingController.clear();
                  community.unitController.clear();
                  community.houseController.clear();
                  community.parkingSpaceController.clear();
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

  void showEditDialog(Community community) {
    selectedCommunity = community;

    TextEditingController buildingController =
    TextEditingController(text: community.building);
    TextEditingController unitController =
    TextEditingController(text: community.unit);
    TextEditingController houseController =
    TextEditingController(text: community.house);
    TextEditingController parkingSpaceController =
    TextEditingController(text: community.parkingSpace);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('编辑小区信息'),
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
                  selectedCommunity!.building = buildingController.text.trim();
                  selectedCommunity!.unit = unitController.text.trim();
                  selectedCommunity!.house = houseController.text.trim();
                  selectedCommunity!.parkingSpace =
                      parkingSpaceController.text.trim();
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
            controller: communities.isNotEmpty
                ? communities.last.buildingController
                : null,
            decoration: InputDecoration(
              labelText: '楼栋',
            ),
          ),
          TextFormField(
            controller: communities.isNotEmpty
                ? communities.last.unitController
                : null,
            decoration: InputDecoration(
              labelText: '单元',
            ),
          ),
          TextFormField(
            controller: communities.isNotEmpty
                ? communities.last.houseController
                : null,
            decoration: InputDecoration(
              labelText: '房屋',
            ),
          ),
          TextFormField(
            controller: communities.isNotEmpty
                ? communities.last.parkingSpaceController
                : null,
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
          itemCount: communities.length,
          itemBuilder: (context, index) {
            Community community = communities[index];
            return ListTile(
              title: Text('楼栋: ${community.buildingController.text}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('单元: ${community.unitController.text}'),
                  Text('房屋: ${community.houseController.text}'),
                  Text('车位: ${community.parkingSpaceController.text}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showEditDialog(community);
                },
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

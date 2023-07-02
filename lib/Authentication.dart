import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  List<String> uploadedImages = [];
  String idCard = '';
  String name = '';
  String address = '';
  String status = '';
  String message = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void onImageUploaded() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      final Uint8List pickedImageBytes = await pickedImage.readAsBytes();
      setState(() {
        String imageString = base64Encode(pickedImageBytes);
        uploadedImages.add(imageString);
      });
    }
  }

  void verifyIdCard() async {
    setState(() {
      status = '';
      message = '';
    });

    final String appCode = 'e74e239e33174302bad09d139fb63bb9'; // 替换为您的AppCode
    final apiUrl = 'https://idcert.market.alicloudapi.com/idcard';

    final idCardQueryParam = 'idCard=' + Uri.encodeComponent(idCard);
    final nameQueryParam = 'name=' + Uri.encodeComponent(name);
    final url = '$apiUrl?$idCardQueryParam&$nameQueryParam';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'APPCODE $appCode',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        status = data['status'];
        message = data['msg'];
        if (status == '01') {
          idCard = data['idCard'];
          name = data['name'];
          // address = data['address'];
        }
      });
    } else {
      setState(() {
        status = 'Error';
        message = '身份验证请求出错';
      });
    }
  }

  void identifyIdCard() async {
    if (uploadedImages.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('错误'),
            content: Text('请先上传身份证图片'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('确认'),
              ),
            ],
          );
        },
      );
      return;
    }

    final String appCode = 'e74e239e33174302bad09d139fb63bb9'; // 替换为您的AppCode
    final apiUrl = 'https://api05.aliyun.venuscn.com/ocr/id-card';
    final type = '1'; // 身份证正面

    final String imageString = uploadedImages.last;

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'APPCODE $appCode',
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
      body: {
        'pic': imageString,
        'type': type,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['ret'] == 200) {
        setState(() {
          final idCardData = data['data'];
          status = '';
          message = '';
          idCard = idCardData['number'];
          name = idCardData['name'];
          address = idCardData['address'];
          nameController.text = name; // 更新姓名文本框的内容
          idCardController.text = idCard; // 更新身份证号码文本框的内容
          addressController.text = address; // 更新住址文本框的内容
        });
      } else {
        setState(() {
          status = 'Error';
          message = '身份证识别失败';
        });
      }
    } else {
      setState(() {
        status = 'Error';
        message = 'OCR请求出错';
      });
    }
  }

  Widget buildUploadedImages() {
    if (uploadedImages.isEmpty) {
      return Container();
    } else {
      return Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '已上传的图片:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: uploadedImages.map((imageData) {
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: MemoryImage(base64Decode(imageData)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildIdCardInfo() {
    if (status == '01') {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '姓名:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: '请输入姓名',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(height: 8),
              Text(
                '身份证号码:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              TextField(
                controller: idCardController,
                decoration: InputDecoration(
                  hintText: '请输入身份证号码',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    idCard = value;
                  });
                },
              ),
              SizedBox(height: 8),
              Text(
                '住址:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: '请输入住址',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('信息已保存'),
                        content: Text('身份信息已更新'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                nameController.text = name;
                                idCardController.text = idCard;
                                addressController.text = address;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text('确认'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('保存信息'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('身份验证'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildUploadedImages(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onImageUploaded,
              child: Text('上传身份证图片'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: identifyIdCard,
              child: Text('识别身份证'),
            ),
            SizedBox(height: 16),
            Text(
              '身份证信息:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('姓名: $name'),
            Text('身份证号码: $idCard'),
            Text('住址: $address'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: verifyIdCard,
              child: Text('验证身份证'),
            ),
            SizedBox(height: 16),
            Text(
              '验证结果:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('状态: $status'),
            Text('消息: $message'),
            SizedBox(height: 16),
            buildIdCardInfo(),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Authentication(),
  ));
}

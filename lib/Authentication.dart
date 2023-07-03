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

  int step = 1;

  @override
  void initState() {
    super.initState();
  }

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
          step = 3;
        }
        else {
          setState(() {
            status = 'Error';
            message = '身份验证请求出错';
          });
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
          step = 2;
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
            Text(
              '上传身份证图片->识别身份证->验证身份证',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Text("${index+1}"),
                  backgroundColor: step > index ? Colors.deepPurple : Colors.grey,
                ),
              )),
            ),
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: uploadedImages.isNotEmpty ?
              Image.memory(base64Decode(uploadedImages.last), fit: BoxFit.cover) :
              Center(child: Text('请上传身份证图片')),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onImageUploaded,
                  child: Text('上传身份证图片'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: identifyIdCard,
                  child: Text('识别身份证'),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: '姓名',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: idCardController,
              decoration: InputDecoration(
                labelText: '身份证号码',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: '住址',
                border: OutlineInputBorder(),
              ),
            ),
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
            Text(status == '01' ? '实名认证成功' : status == 'Error' ? '实名认证失败' : ''),
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

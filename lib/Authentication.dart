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
  String idCard = '66666666';
  String name = '徐尚';
  String status = '';
  String message = '';

  void onImageUploaded() async {
    final Uint8List? pickedImage = await ImagePicker().getImage(source: ImageSource.gallery).then((value) => value!.readAsBytes());
    if (pickedImage != null) {
      setState(() {
        String imageString = base64Encode(pickedImage);
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
        }
      });
    } else {
      setState(() {
        status = 'Error';
        message = '身份验证请求出错';
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (status == '01') ...[
                Text('姓名: $name'),
                Text('身份证号码: $idCard'),
              ],
            ],
          ),
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
          status = 'Success';
          message = '身份证识别成功';
          idCard = idCardData['number'];
          name = idCardData['name'];
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (status == 'Success') ...[
                Text('姓名: $name'),
                Text('身份证号码: $idCard'),
              ],
            ],
          ),
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
  }

  Widget buildUploadedImages() {
    if (uploadedImages.isEmpty) {
      return Container();
    } else {
      return Column(
        children: [
          Text(
            '已上传的图片:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: uploadedImages.map((imageData) {
                return Container(
                  margin: EdgeInsets.all(8),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(base64Decode(imageData)),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('身份验证'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildUploadedImages(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onImageUploaded,
              child: Text('请上传身份证图片'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: identifyIdCard,
              child: Text('身份证识别'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: verifyIdCard,
              child: Text('身份检验'),
            ),
            SizedBox(height: 16),
            Text(
              '检验结果',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('状态: $status'),
            Text('信息: $message'),
            if (status == '01') ...[
              Text('姓名: $name'),
              Text('身份证号码: $idCard'),
            ],
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: '身份验证',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: Authentication(),
  ));
}

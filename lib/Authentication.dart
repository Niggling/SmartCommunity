import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'image_selection_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  List<String> uploadedImages = [];
  String idCard = '310115200203049218';
  String name = '徐尚';
  String status = '';
  String message = '';

  @override
  void initState() {
    super.initState();
  }

  void onImageUploaded() async {
    final Uint8List? pickedImage = await ImageSelectionPage.pickImage();
    if (pickedImage != null) {
      setState(() {
        String imageString = base64Encode(pickedImage);
        uploadedImages.add(imageString);
      });
    }
  }

  void submitProblemReport() async {
    setState(() {
      status = '';
      message = '';
    });

    final String appCode = 'e74e239e33174302bad09d139fb63bb9';
    final apiUrl = 'https://idcert.market.alicloudapi.com/idcard';

    // 构建正确的URL参数
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
        message = 'An error occurred during the authentication request.';
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
        title: Text('身份证实名认证'),
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
              child: Text('上传图片'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: submitProblemReport,
              child: Text('认证'),
            ),
            SizedBox(height: 16),
            Text(
              '认证结果',
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
    home: Authentication(),
  ));
}

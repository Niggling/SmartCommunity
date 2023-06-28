import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsPage(),
    );
  }
}

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  File? _selectedImage;
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submitNews() {
    String title = _titleController.text;
    String content = _contentController.text;

    // TODO: Perform news submission logic here
    // You can send the title and content to a server or store them locally

    // Reset the input fields
    _titleController.clear();
    _contentController.clear();

    // Show a success message or navigate to another screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('成功'),
          content: Text('成功上传公告!'),
          actions: [
            TextButton(
              child: Text('确认'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
        title: Text('公告发布'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '标题',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: '内容',
              ),
            ),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Existing code for title, content, and submit button

                SizedBox(height: 16.0),

                // Display the selected image if available
                if (_selectedImage != null)
                  Image.file(_selectedImage!),

                // Button to pick an image
                ElevatedButton(
                  child: Text('选择图片'),
                  onPressed: _pickImage,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('上传'),
              onPressed: _submitNews,
            ),
          ],
        ),
      ),
    );
  }
}

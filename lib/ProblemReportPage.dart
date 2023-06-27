import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'image_selection_page.dart';
import 'dart:convert';

class ProblemReportPage extends StatefulWidget {
  @override
  _ProblemReportPageState createState() => _ProblemReportPageState();
}

class _ProblemReportPageState extends State<ProblemReportPage> {
  String problemDescription = '';
  List<String> uploadedImages = [];
  VideoPlayerController? videoController;
  late Future<void> initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    initializeControllerFuture = initializeVideoController();
  }

  // Function to handle problem description input
  void onDescriptionChanged(String value) {
    setState(() {
      problemDescription = value;
    });
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

  void onVideoSelected() async {
    final pickedVideo = await ImagePicker().getVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      final videoPath = pickedVideo.path;
      videoController = VideoPlayerController.network(videoPath);
      await videoController!.initialize();
      setState(() {
        initializeControllerFuture = videoController!.play();
      });
    }
  }

  Future<void> initializeVideoController() async {
    await videoController?.initialize();
    setState(() {});
  }

  void submitProblemReport() {
    setState(() {
      problemDescription = '';
      uploadedImages = [];
      videoController?.dispose();
      videoController = null;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('问题报告已提交'),
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
                  margin: EdgeInsets.only(right: 8),
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

  Widget buildUploadedVideo() {
    if (videoController == null) {
      return Container();
    } else {
      return Column(
        children: [
          Text(
            '已上传的视频:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          Container(
            width: 200,
            height: 200,
            child: AspectRatio(
              aspectRatio: videoController!.value.aspectRatio,
              child: VideoPlayer(videoController!),
            ),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('问题上报'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '问题描述:',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                onChanged: onDescriptionChanged,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: '请输入问题描述',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                '图片上传:',
                style: TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: onImageUploaded,
                child: Text('选择图片'),
              ),
              SizedBox(height: 8),
              buildUploadedImages(),
              SizedBox(height: 16),
              Text(
                '视频上传:',
                style: TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: onVideoSelected,
                child: Text('选择视频'),
              ),
              SizedBox(height: 8),
              buildUploadedVideo(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: submitProblemReport,
                child: Text('提交问题报告'),
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
    home: ProblemReportPage(),
  ));
}

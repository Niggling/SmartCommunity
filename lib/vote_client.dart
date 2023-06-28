import 'package:flutter/material.dart';

void main() {
  runApp(VotingApp());
}

class VotingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '业主投票',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VotingPage(),
    );
  }
}

class VotingPage extends StatefulWidget {
  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  List<VoteItem> voteItems = [
    VoteItem('公共照明费用  1000元', ['同意', '反对']),
    VoteItem('花园维护费用  2000元', ['同意', '反对']),
    VoteItem('安保系统费用  8000元', ['同意', '反对']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('业主投票'),
      ),
      body: ListView.builder(
        itemCount: voteItems.length,
        itemBuilder: (BuildContext context, int index) {
          return VoteItemWidget(voteItems[index]);
        },
      ),
    );
  }
}

class VoteItem {
  final String title;
  final List<String> options;
  bool voted;

  VoteItem(this.title, this.options) : voted = false;
}

class VoteItemWidget extends StatefulWidget {
  final VoteItem voteItem;

  VoteItemWidget(this.voteItem);

  @override
  _VoteItemWidgetState createState() => _VoteItemWidgetState();
}

class _VoteItemWidgetState extends State<VoteItemWidget> {
  String selectedOption = '';
  bool hasVoted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.voteItem.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.voteItem.options.length,
            itemBuilder: (BuildContext context, int index) {
              final option = widget.voteItem.options[index];
              return ListTile(
                title: Text(option),
                leading: Radio<String>(
                  value: option,
                  groupValue: selectedOption,
                  onChanged: hasVoted
                      ? null
                      : (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                ),
              );
            },
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: hasVoted ? null : submitVote,
            child: Text('提交投票'),
          ),
        ],
      ),
    );
  }

  void submitVote() {
    if (selectedOption.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('投票结果'),
            content: Text('您选择的是: $selectedOption'),
            actions: [
              TextButton(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      setState(() {
        widget.voteItem.voted = true;
        hasVoted = true;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('投票失败'),
            content: Text('请先选择一个选项'),
            actions: [
              TextButton(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

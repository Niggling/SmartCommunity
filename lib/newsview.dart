import 'package:flutter/material.dart';




class NewsAppView extends StatelessWidget {
  final List<News> newsList = [
    News(
      title: '扬州新商场',
      content: '2022年底，邗江区政府官网一则《高新区万达广场交通影响评价项目招标公告》，让周边居民欣喜不已： 万达广场要来了！',
    ),
    News(
      title: '九部门印发《关于深入推进智慧社区建设的意见》的通知',
      content: '智慧社区是充分应用大数据、云计算、人工智能等信息技术手段，整合社区各类服务资源，'
          '打造基于信息化、智能化管理与服务的社区治理新形态。为充分运用现代信息技术，'
          '不断提升城乡社区治理服务智慧化、智能化水平，'
          '根据《中共中央 国务院关于加强基层治理体系和治理能力现代化建设的意见》、'
          '《国务院办公厅关于印发〈“十四五”城乡社区服务体系建设规划〉的通知》等文件要求，'
          '现就推进智慧社区建设提出如下意见：',
    ),
    // Add more news items as needed
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset(
                'assets/images/news_icon.jpg', // Replace with your image path
                width: 48,
                height: 48,
              ),
              title: Text(newsList[index].title),
              subtitle: Text(newsList[index].content),
            ),
          );
        },
      ),
    );
  }
}

class News {
  final String title;
  final String content;

  News({required this.title, required this.content});
}

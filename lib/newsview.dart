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
    News(
      title: '新产品发布会',
      content: '本公司将于下个月举办新产品发布会，届时将会展示一系列创新产品。敬请关注！'
          '新产品包括智能手机、智能手表、智能家居设备等等。这些产品拥有领先的技术和卓越的性能，'
          '将为用户带来更便捷、智能的生活体验。',
    ),
    News(
      title: '高速公路交通管制',
      content: '由于道路维修工程，部分高速公路将在本周末进行交通管制。'
          '受影响的路段包括罗辑公路、北京公路和北外滩立交桥。为避免不必要的延误，请提前规划您的出行。'
          '如果您需要前往这些地区，请选择其他交通路线或者调整出行时间。',
    ),
    News(
      title: '新医院开业',
      content: '我们很高兴地宣布，华夏中医院将于本月底正式开业。新医院配备了最先进的设备和技术，'
          '拥有一流的医疗团队，致力于为患者提供高质量的医疗服务。我们将为社区居民提供全方位的医疗保健。',
    ),
    News(
      title: '城市公园改造计划',
      content: '根据城市发展规划，我们计划对社区中心的公园进行改造和升级。'
          '改造后的公园将增加更多的绿化植物、休闲设施和娱乐活动区域，'
          '为居民创造一个美丽宜人的休闲场所。改造工程将于近期开始。',
    ),
  ];

// You can add more News objects here if needed




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

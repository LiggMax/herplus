import 'package:flutter/material.dart';
import 'package:herplus/core/utils/nav_utils.dart';
import 'package:herplus/pages/body_heart/body_heart_page.dart';
import 'package:herplus/pages/community/community_page.dart';
import 'package:herplus/pages/index/index_page.dart';
import 'package:herplus/pages/mine/mine_page.dart';
import 'package:herplus/pages/temp_pages/base_data_page.dart';
import 'package:herplus/pages/temp_pages/heart_error/heart_error_page.dart';
import 'package:herplus/pages/temp_pages/lab_page.dart';
import 'package:herplus/pages/temp_pages/period_page.dart' show PeriodPage;
import 'package:herplus/pages/temp_pages/power_detail_page.dart';
import 'package:herplus/pages/temp_pages/report_page.dart';
import 'package:herplus/pages/temp_pages/sleep_detail_page.dart';
import 'package:herplus/pages/temp_pages/stress_page.dart';

import 'app_page/index.dart';
import 'new/new_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 背景图片
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                // fit: BoxFit.contain,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 页面内容
          PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            children: [
              IndexPage(),
              BodyHeartPage(),
              NewPage(),
              CommunityPage(),
              MinePage(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 28),
        height: 62, // 手动控制高度
        decoration: BoxDecoration(
          color: Color(0xFF0C0C0C).withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.white),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              0,
              'assets/icons/home.png',
              'assets/icons/home_1.png',

              '此刻',
            ),
            _buildNavItem(
              1,
              'assets/icons/heart.png',
              'assets/icons/heart_1.png',

              '身心',
            ),
            _buildNavItem(
              2,
              'assets/icons/new.png',
              'assets/icons/new_1.png',

              '焕新',
            ),
            _buildNavItem(
              3,
              'assets/icons/com.png',
              'assets/icons/com_1.png',

              '社区',
            ),
            _buildNavItem(
              4,
              'assets/icons/mine.png',
              'assets/icons/mine_1.png',

              '我的',
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              NavUtils.push(AppPage());
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              color: Colors.white,
              height: 40,
              width: 40,
              child: Center(child: Text("跳转菜单")),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavUtils.push(BaseDataPage());
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              color: Colors.white,
              height: 40,
              width: 40,
              child: Center(child: Text("跳转页面 1")),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavUtils.push(StressPage());
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              color: Colors.white,
              height: 40,
              width: 40,
              child: Center(child: Text("跳转页面 1")),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavUtils.push(SleepDetailPage());
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8),

              color: Colors.white,
              height: 40,
              width: 40,
              child: Center(child: Text("跳转页面 1")),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavUtils.push(PeriodPage());
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8),

              color: Colors.white,
              height: 40,
              width: 40,
              child: Center(child: Text("跳转页面 1")),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavUtils.push(PowerDetailPage());
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8),

              color: Colors.white,
              height: 40,
              width: 40,
              child: Center(child: Text("跳转页面 1")),
            ),
          ), // 占位，避免与底部导航栏重叠
          GestureDetector(
            onTap: () {
              NavUtils.push(HeartErrorPage());
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8),

              color: Colors.white,
              height: 40,
              width: 40,
              child: Center(child: Text("跳转页面 1")),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavUtils.push(ReportPage());
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8),

              color: Colors.white,
              height: 40,
              width: 40,
              child: Center(child: Text(" 1")),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavUtils.push(LabPage());
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8),

              color: Colors.white,
              height: 40,
              width: 40,
              child: Center(child: Text("跳转页面 1")),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String iconPath,
    String selectedIconPath,
    String label,
  ) {
    final isSelected = (index == _currentIndex);
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isSelected
              ? Colors.white
              : Color(0xFFFFFFFF).withValues(alpha: 0.2),
        ),

        width: 40,
        height: 40,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isSelected ? selectedIconPath : iconPath,
              width: 21,
              height: 21,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Color(0xFF8E9572) : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

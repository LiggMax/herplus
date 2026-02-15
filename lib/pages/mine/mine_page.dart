import 'package:flutter/material.dart';
import 'package:herplus/core/utils/nav_utils.dart';
import 'package:herplus/pages/algorithm_calibration/algorithm_calibration.dart';
import 'package:herplus/pages/data_privacy/data_privacy.dart';
import 'package:herplus/pages/device_manager/device_manager.dart';
import 'package:herplus/pages/merge/system_settings.dart';

import '../temp_pages/report_page.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: buildContent(),
    );
  }

  buildContent() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            buildMineWidget(),
            buildDeviceWidget(),
            buildService(),
            buildFuncCard(),
          ],
        ),
      ),
    );
  }

  buildMineWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Image.asset("assets/images/avatar.png", width: 60, height: 60),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("MARTIN", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 7),
                  Image.asset("assets/images/vip.png", width: 92, height: 24),
                ],
              ),
              SizedBox(height: 5),
              Text(
                "USER@1324004040",
                style: TextStyle(color: Color.fromARGB(109, 107, 111, 100)),
              ),
            ],
          ),
          Spacer(),
          Image.asset("assets/icons/forward.png", width: 38, height: 38),
        ],
      ),
    );
  }

  buildDeviceWidget() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            NavUtils.push(DeviceManagerPage());
          },
          child: Container(
            padding: EdgeInsets.all(20),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/device_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "张三的手表",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 2),
                    Container(
                      width: 50,
                      height: 18,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withAlpha(14),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE5DBFE),
                            ),
                          ),
                          Text(
                            "已连接",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 65,
                      height: 28,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/energe.png"),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 4,
                            right: 7,
                            child: Text(
                              "70%",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 65,
                      height: 28,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/version.png"),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 4,
                            right: 7,
                            child: Text(
                              "70%",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Container(
                          height: 6,
                          width: constraints.maxWidth,
                          decoration: BoxDecoration(
                            color: Color(0xFF979797),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 6,
                          width: constraints.maxWidth * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -10,
          right: 31,
          child: Container(
            width: 93,
            height: 109,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ring.png"),
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildService() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () {
                NavUtils.push(ReportPage());
              },
              child: buildReportCard()),
        ),
        SizedBox(width: 7),
        Expanded(
          child: Column(
            children: [
              buildRenewCard(),
              SizedBox(height: 8),
              GestureDetector(
                  onTap: () {
                    NavUtils.push(AlgorithmCalibrationPage());
                  },
                  child: buildLogicCard())
            ],
          ),
        ),
      ],
    );
  }

  buildReportCard() {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/report.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "AI报告",
            style: TextStyle(color: Colors.white.withAlpha(65), fontSize: 26),
          ),
          SizedBox(height: 28),
          Text("算法校准", style: TextStyle(color: Colors.white)),
          SizedBox(height: 28),
        ],
      ),
    );
  }

  buildRenewCard() {
    return Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/renew.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("算法校准", style: TextStyle(color: Colors.white)),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  buildLogicCard() {
    return Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/logic.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("算法校准", style: TextStyle(color: Colors.white)),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  buildFuncCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      height: 207,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/func_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFuncRow("账号安全", "assets/icons/people.png", null),
          Divider(color: Colors.white.withAlpha(24)),
          GestureDetector(
            onTap: () {
              NavUtils.push(DataPrivacyPage());
            },
            child: _buildFuncRow("隐私数据", "assets/icons/sercurity.png", null),
          ),
          Divider(color: Colors.white.withAlpha(24)),
          _buildFuncRow("关于/客服", "assets/icons/about.png", null),
          Divider(color: Colors.white.withAlpha(24)),
          GestureDetector(
            onTap: () {
              NavUtils.push(SystemSettingsPage());
            },
            child: _buildFuncRow("系统与设置", "assets/icons/settings.png", null),
          )
        ],
      ),
    );
  }

  _buildFuncRow(String title, String iconPath, VoidCallback? onTap) {
    return Row(
      children: [
        Image.asset(iconPath, width: 20, height: 20),
        SizedBox(width: 14),
        Text(title),
        Spacer(),
      ],
    );
  }
}

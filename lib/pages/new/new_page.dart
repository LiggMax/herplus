import 'package:flutter/material.dart';
import 'package:herplus/core/utils/nav_utils.dart';
import 'package:herplus/pages/expert_details/expert_details.dart';
import 'package:herplus/pages/new/tabs.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle("每日处方流"),
            buildBanner(),
            buildTitle("专家阵容流"),
            SizedBox(height: 10),
            TabsView(),
            buildExperts(),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 16),
                Image.asset("assets/images/ai_box.png", width: 30, height: 30),
                buildTitle("AI 周期信箱"),
              ],
            ),
            buildBox(),
          ],
        ),
      ),
    );
  }

  buildBanner() {
    return Container(
      height: 220,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 34),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/banner.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("3分钟盒子呼吸法", style: TextStyle(color: Colors.white, fontSize: 20)),
          Row(
            children: [
              Image.asset("assets/images/doctor.png", width: 24, height: 24),
              SizedBox(width: 6),
              Text("李医生·睡眠专家", style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color(0xFF0E0E0E).withAlpha(125),
            ),
            child: Text(
              "助眠/减压/经期/专注/营养/亲密关系",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  buildTitle(String title) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A2A2A), Color(0xFFF8B595)],
          stops: [0.0, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Colors.white, // Required for ShaderMask to show colors
            ),
          ),
        ],
      ),
    );
  }

  buildExperts() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              NavUtils.push(ExpertDetailsPage());
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.all(20),
              height: 181,
              width: 127,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/expert_1.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("名字",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text(
                    "专业领域",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavUtils.push(ExpertDetailsPage());
            },
            child: Container(
              height: 181,
              width: 127,
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/expert_2.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("名字",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text(
                    "专业领域",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavUtils.push(ExpertDetailsPage());
            },
            child: Container(
              height: 181,
              width: 127,
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/expert_2.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("名字",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text(
                    "专业领域",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavUtils.push(ExpertDetailsPage());
            },
            child: Container(
              height: 181,
              width: 127,
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/expert_2.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("名字",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text(
                    "专业领域",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildBox() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/box_into.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

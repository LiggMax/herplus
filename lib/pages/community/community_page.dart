import 'package:flutter/material.dart';
import 'package:herplus/core/utils/nav_utils.dart';
import 'package:herplus/pages/community/report/report_page.dart';
import 'package:herplus/pages/temp_pages/lab_page.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("社区", style: TextStyle(fontSize: 16)),
      ),
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: buildContent(),
    );
  }

  buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildCommunityCard(),
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(child: buildAsset()),
                Expanded(child: buildRevenue()),
              ],
            ),
            buildDeci(),

            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Column(
                    children: [buildTextSource(), buildBreakBound()],
                  ),
                ),
                Expanded(child: buildHealth()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildCommunityCard() {
    return Container(
      padding: EdgeInsets.all(16),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/community_card_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Herplus社区", style: TextStyle(color: Colors.white)),
          SizedBox(height: 18),
          Text(
            "她的力量，定义未来",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 6),
          Text(
            "DEC 20 ·FRI",
            style: TextStyle(color: Colors.white.withAlpha(65), fontSize: 16),
          ),
        ],
      ),
    );
  }

  buildAsset() {
    return Container(
      padding: EdgeInsets.all(16),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/assets.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SHE IMPACTS",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 12),
          Text(
            "本月累计资助",
            style: TextStyle(color: Colors.white.withAlpha(85), fontSize: 12),
          ),
          SizedBox(height: 2),
          Text("\$12,400", style: TextStyle(color: Colors.white, fontSize: 20)),
          SizedBox(height: 4),
          Text(
            "\$12,400",
            style: TextStyle(color: Colors.white.withAlpha(85), fontSize: 12),
          ),
        ],
      ),
    );
  }

  buildRevenue() {
    return GestureDetector(
      onTap: () {
        NavUtils.push(LabPage());
      },
      child: Container(
        padding: EdgeInsets.all(16),
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/revenue.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Data Lab",
              style: TextStyle(color: Colors.white.withAlpha(85), fontSize: 14),
            ),
            SizedBox(height: 22),
            Text(
              "3个项目正在招募",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              "填补女性健康空白",
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  buildDeci() {
    return Container(
      padding: EdgeInsets.all(20),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/deci.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        alignment: AlignmentGeometry.bottomCenter,
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF2E332F).withAlpha(40),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(children: [buildDeciDetails(), buildDeciDetails()]),
          ),
        ],
      ),
    );
  }

  buildDeciDetails() {
    return Row(
      children: [
        Container(
          width: 55,
          height: 55,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "DEC",
                style: TextStyle(color: Color(0xFF636751), fontSize: 12),
              ),
              Text("24", style: TextStyle(color: Color(0xFF636751))),
            ],
          ),
        ),
        SizedBox(width: 2),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("年度慈善晚宴", style: TextStyle(color: Colors.white)),
            Text(
              "上海中心",
              style: TextStyle(color: Colors.white.withAlpha(65), fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  buildTextSource() {
    return Container(
      padding: EdgeInsets.all(16),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/text_source.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("我们不需要适应世界,", style: TextStyle(color: Colors.white)),
          Text("我们需要改变世界。", style: TextStyle(color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("文字来源", style: TextStyle(color: Colors.white))],
          ),
        ],
      ),
    );
  }

  buildBreakBound() {
    return Container(
      padding: EdgeInsets.all(16),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/break.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("打破边界", style: TextStyle(color: Colors.white.withAlpha(85))),
          Text(
            "女性科技领袖\n专访",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  buildHealth() {
    return Container(
      padding: EdgeInsets.all(16),
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/heath.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("经期追踪与健康", style: TextStyle(color: Colors.white)),
          Column(
            children: [
              Text(
                "经期追踪与健康",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "你需要知道的健康常识",
                style: TextStyle(
                  color: Colors.white.withAlpha(85),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

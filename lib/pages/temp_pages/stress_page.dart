import 'dart:ui';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';

import 'chart/pressure_chart.dart';

class StressPage extends StatelessWidget {
  const StressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
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
          buildContent(context),
        ],
      ),
    );
  }

  buildContent(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 16),
                        buildTabs(context),
                      ],
                    ),
                    SizedBox(height: 15),

                    buildPannelGrids(),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            buildLineChart(),
          ],
        ),
      ),
    );
  }

  buildTabs(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      fixedWidth: 90,
      height: 40,
      initialValue: 0,
      children: {
        0: Text('日', style: TextStyle(color: Colors.white, fontSize: 16)),
        1: Text('月', style: TextStyle(color: Colors.white, fontSize: 16)),
        2: Text('年', style: TextStyle(color: Colors.white, fontSize: 16)),
      },
      innerPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/tab_bg.png'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            Colors.white.withAlpha(180),
            BlendMode.srcATop,
          ),
        ),
      ),
      thumbDecoration: BoxDecoration(
        color: Color(0x3B000000).withOpacity(0.23),
        borderRadius: BorderRadius.circular(100),
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      onValueChanged: (v) {
        print(v);
      },
    );
  }

  buildPannelGrids() {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: buildPannelGridItem(
                bgImage: 'assets/images/bg_1.png',
                title: '步数',
                unit: '步',
                data: '8567',
                labelPath: 'assets/images/label1.png',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: buildPannelGridItem(
                bgImage: 'assets/images/drop_bg.png',
                title: '心率',
                unit: '次/分',
                data: '78',
                labelPath: 'assets/images/label2.png',
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: buildPannelGridItem(
                bgImage: 'assets/images/breath_bg.png',
                title: '呼吸',
                unit: '次/分',
                data: '18',
                labelPath: 'assets/images/label3.png',
              ),
            ),
            SizedBox(width: 12),

            Expanded(
              child: buildPannelGridItem(
                bgImage: 'assets/images/tem_bg.png',
                title: '体温',
                unit: '℃',
                data: '36.5',
                labelPath: 'assets/images/label4.png',
              ),
            ),
          ],
        ),
      ],
    );
  }

  buildPannelGridItem({
    required String bgImage,
    required String title,
    String? unit,
    String? data,
    required labelPath,
  }) {
    return Container(
      height: 120,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.fill),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data ?? '',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title, style: TextStyle(fontSize: 13, color: Colors.white)),
          Image.asset(labelPath, width: 40, height: 19),
        ],
      ),
    );
  }

  buildLineChart() {
    return Container(
      height: 700,
      padding: EdgeInsets.symmetric(vertical: 22.5, horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/list_bg.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        children: [
          Row(children: [Text("🤧 压力分析", style: TextStyle(fontSize: 16))]),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFB2DFDB),
                        Color(0xFFFFCCBC),
                        Color(0xFFE1BEE7),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black.withValues(alpha: 0.3),
                        ),
                        child: Icon(Icons.content_paste_outlined,color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("今日平均压力",style: TextStyle(fontSize: 12),),
                          Row(
                            children: [
                              Text("42",style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: 2),

                              _GlassLabel(text: '偏低', textColor: const Color(0xFFE53935)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF9EC3F6),
                        Color(0xFFF6CF6E),
                        Color(0xFFDDCBEB),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        offset: Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.monitor_heart_sharp, color: Colors.white, size: 22),
                      ),
                      SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("HRV", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12)),
                          Row(
                            children: [
                              Text("58", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                              SizedBox(width: 2),
                              Text("ms", style: TextStyle(fontSize: 13, color: Colors.black87)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          FancyLineChart(),
          Row(children: [Text("📝 情绪气象记录", style: TextStyle(fontSize: 16))]),
          Image.asset(
            'assets/images/fake_line2.png',
            height: 222,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

class _GlassLabel extends StatelessWidget {
  final String text;
  final Color textColor;

  const _GlassLabel({required this.text, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

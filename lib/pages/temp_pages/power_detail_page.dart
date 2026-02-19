import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:herplus/core/utils/nav_utils.dart';
import 'package:herplus/goal_setting/goal_settings.dart';

import 'chart/trend_chart.dart';

class PowerDetailPage extends StatelessWidget {
  const PowerDetailPage({super.key});

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
              child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => NavUtils.pop(),
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () => NavUtils.pop(),
                        //     icon: Icon(
                        //       Icons.arrow_back_ios_new_outlined,
                        //       color: Colors.white,
                        //     )),
                        SizedBox(width: 16),
                        buildTabs(context),
                      ],
                    ),
                    SizedBox(height: 15),
                    Image.asset(
                      'assets/images/fake3_1.png',
                      height: 138,
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      'assets/images/fake3_2.png',
                      height: 210,
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                    ),
                    // TrendChart()
                  ],
                ),
            ),
            Container(
              height: 472,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/list_bg4.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "📄 活动概览",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            NavUtils.push(GoalSettingsPage());
                          },
                          child: Image.asset(
                            'assets/images/setting.png',
                            width: 90,
                            height: 24,
                          )),
                    ],
                  ),
                  SizedBox(height: 12),
                  Image.asset(
                    'assets/images/fake3_3.png',
                    height: 137,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Row(
                    children: [
                      Text(
                        "💪 强度分布",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/fake3_4.png',
                    height: 220,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
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
}

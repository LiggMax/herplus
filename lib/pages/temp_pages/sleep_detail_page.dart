import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:herplus/pages/temp_pages/chart/sleep_chart.dart';
import 'package:herplus/pages/temp_pages/chart/sleep_donut_chart.dart';

import 'breathing_and_recovery.dart';

class SleepDetailPage extends StatelessWidget {
  const SleepDetailPage({super.key});

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
              padding: EdgeInsets.symmetric(horizontal: 16),
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

                    // Stack(
                    //   children: [
                    //     Image.asset(
                    //       'assets/images/fake1.png',
                    //       height: 340,
                    //       fit: BoxFit.fitWidth,
                    //
                    //       width: MediaQuery.of(context).size.width,
                    //     ),
                    //     Positioned(
                    //       top: 42,
                    //       left: -30,
                    //       child: Image.asset(
                    //         'assets/images/cloud.png',
                    //         height: 116,
                    //         width: MediaQuery.of(context).size.width,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SleepChart(),
                    SizedBox(height: 8),
                    SleepDonutChart(),
                    SizedBox(height: 8),
                    BreathingAndRecovery()
                  ],
                ),
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

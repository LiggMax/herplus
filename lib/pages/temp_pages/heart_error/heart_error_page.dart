import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:herplus/constants/image_constant.dart';
import 'package:herplus/constants/svg_constant.dart';
import 'package:herplus/core/utils/nav_utils.dart';

import 'exception_summary_view.dart';

class HeartErrorPage extends StatelessWidget {
  const HeartErrorPage({super.key});

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => NavUtils.pop(context),
                          child: Icon(Icons.arrow_back_ios_new_outlined),
                        ),
                        Text("心率异常详情", style: TextStyle(fontSize: 16)),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border(
                                  left: BorderSide(
                                      width: 0.6, color: Colors.white),
                                  top: BorderSide(
                                      width: 0.6, color: Colors.white),
                                  bottom: BorderSide(
                                      width: 0.6, color: Colors.white)),
                              gradient: LinearGradient(
                                colors: [Color(0xFF6B86B5), Color(0xFF4FA9A6)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          child: Row(
                            children: [
                              Text('10/26',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 15,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 22),
                    ExceptionSummaryView(),
                    SizedBox(height: 12),
                    Image.asset(
                      'assets/images/fake4_2.png',
                      height: 256,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _Card(title: '运动步数', content: '1,200'),
                        _Card(
                          title: '运动强度',
                          content: '低',
                        ),
                        _Card(title: '运动时长', content: '12分钟'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        //底部阴影
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            offset: Offset(0, 5),
                            blurRadius: 5,
                          )
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xFF45534A), Color(0xFF584B45)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('了解心率指标',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                                Icon(Icons.arrow_forward,
                                    size: 15, color: Colors.white)
                              ],
                            ),
                            Text(
                              '建议进行3分钟呼吸练习',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '若持续异常建议咨询医生',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white54,
                                  height: 2),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border(
                                      left: BorderSide(
                                          width: 0.6, color: Colors.white),
                                      top: BorderSide(
                                          width: 0.6, color: Colors.white),
                                      bottom: BorderSide(
                                          width: 0.6, color: Colors.white)),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF678AB3),
                                      Color(0xFF4FA9A6)
                                    ],
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '开始呼吸练习',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Colors.white.withValues(alpha: 0.8),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 5),
                                  SvgPicture.asset(svgRightArrow)
                                ],
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String content;

  const _Card({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 28, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xFFCAC7BC),
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 15, color: Colors.black38),
        ),
        Text(content,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500))
      ]),
    );
  }
}

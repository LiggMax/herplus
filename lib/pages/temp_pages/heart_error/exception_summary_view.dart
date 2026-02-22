import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:herplus/constants/svg_constant.dart';

class ExceptionSummaryView extends StatelessWidget {
  const ExceptionSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          color: Color(0xFFE6E5E5),
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: AssetImage('assets/images/bg/green_and_pink_background1.png'),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            width: 0.5,
            color: Colors.white,
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(svgHeart),
                const SizedBox(width: 5),
                Text('异常摘要',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                      right: 5, left: 15, top: 1, bottom: 1),
                  decoration: BoxDecoration(
                    color: Color(0xFFE2C9CC),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '非运动状态',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFA1841).withValues(alpha: 0.8)),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: '110',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFFFD2C72),
                          fontWeight: FontWeight(1000),
                        )),
                    TextSpan(
                        text: 'bpm',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        )
                    )
                  ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 1,
                  height: 20,
                  color: Colors.black12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '阈值',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '100',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      TextSpan(text: 'bpm')
                    ]))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '触发时段: ',
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.black45
                      )
                  ),
                  TextSpan(
                      text: '14:00 - 15:00',
                      style: TextStyle(
                        fontSize: 11,
                      )
                  )
                ])),
              ],
            )
          ],
        ),
      ) ,
    );
  }
}

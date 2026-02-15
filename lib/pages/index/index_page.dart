import 'package:flutter/material.dart';
import 'package:herplus/core/utils/nav_utils.dart';
import 'package:herplus/pages/temp_pages/base_data_page.dart';
import 'package:herplus/pages/temp_pages/heart_error_page.dart';
import 'package:herplus/pages/temp_pages/period_page.dart';
import 'package:herplus/pages/temp_pages/power_detail_page.dart';
import 'package:herplus/pages/temp_pages/sleep_detail_page.dart';
import 'package:herplus/pages/temp_pages/stress_page.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            Column(children: [buildContent()]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [buildBubble()],
            ),
          ],
        ),
      ),
    );
  }

  //MARK 主区域
  buildContent() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildGreeting(),
            SizedBox(height: 22),
            buildDeviceCannection(),
            SizedBox(height: 107),
            Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: buildHeart()),
                Expanded(
                  child: Column(children: [buildFeeling(), buildSleep()]),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Expanded(child: buildStress())],
            ),
            Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [buildThinking(), buildExpert()],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [buildSay(), buildSpecialday()],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //MARK 问候语
  buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text('Ech DoReMe', style: TextStyle(fontSize: 30, color: Colors.white)),
        SizedBox(height: 1),
        Text(
          "早上好",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  buildDeviceCannection() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 4),
              Text(
                "已连接",
                style: TextStyle(fontSize: 12, color: Color(0xFF333333)),
              ),
            ],
          ),
        ),
        SizedBox(width: 4),
        Image.asset('assets/icons/refresh.png', width: 17, height: 17),
      ],
    );
  }

  buildBubble() {
    return SafeArea(
      child: Container(
        width: 170,
        height: 170,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bubble.png')),
        ),
        margin: EdgeInsets.only(right: 18, top: 43),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("能量指数", style: TextStyle(fontSize: 18, color: Colors.white)),
            Text("88", style: TextStyle(fontSize: 40, color: Colors.white)),
            Text("SHER对话", style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  //MARK 心率
  buildHeart() {
    return GestureDetector(
      onTap: () {
        NavUtils.push(BaseDataPage());
      },
      child: Container(
        padding: EdgeInsets.all(16),
        height: 260,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/heart_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("心如止水", style: TextStyle(fontSize: 18, color: Colors.white)),
            Text("心率", style: TextStyle(fontSize: 10, color: Colors.white)),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "94 ",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        "bpm",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CustomPaint(
                        size: Size.infinite,
                        painter: SmoothLineChartPainter(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildFeeling() {
    return Container(
      padding: EdgeInsets.all(16),
      height: 135,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/feeling.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("情绪洞察", style: TextStyle(fontSize: 18, color: Colors.white)),
          Text(
            "最近你的睡眠状态不太好了",
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: CustomPaint(painter: LineChartPainter()),
            ),
          ),
        ],
      ),
    );
  }

  buildSleep() {
    return GestureDetector(
      onTap: () => NavUtils.push(SleepDetailPage()),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 135,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sleep.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("睡梦空间", style: TextStyle(fontSize: 18, color: Colors.white)),
            Text(
              "最近你的睡眠状态不太好了",
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: "5",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: "小时",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: "31",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: "分钟",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildStress() {
    return GestureDetector(
      onTap: () {
        NavUtils.push(StressPage());
      },
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/stress.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Stack(
                alignment: AlignmentGeometry.bottomCenter,
                children: [
                  for (int i = 0; i < 25; i++)
                    Transform.rotate(
                      angle: (i - 12) * 7 * (3.1415926535 / 180),
                      origin: const Offset(0, 100),
                      child: Image.asset(
                        i < 18
                            ? "assets/images/clutter_1.png"
                            : "assets/images/clutter.png",
                        width: 30,
                        height: 30,
                      ),
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "压力缓冲",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "压力值76.5",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      "慢下来花点时间和我进行呼吸练习吧",
                      style: TextStyle(fontSize: 8, color: Colors.white),
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

  buildThinking() {
    return
      GestureDetector(
        onTap: () => NavUtils.push(PowerDetailPage()),
        child: Container(
          padding: EdgeInsets.all(20),
          height: 230,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/thinking.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "冥想建议",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "开始今日冥想三分钟",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                  Text(
                    "今日脑力消耗较大建议试听\n白噪音“雨打芭蕉”",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 82,
                      height: 82,
                      child: CircularProgressIndicator(
                        value: 0.7,
                        backgroundColor: Colors.white.withAlpha(20),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 10,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Text(
                      "3min",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
      ;
  }

  buildExpert() {
    return Container(
      height: 90,
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/expert.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Text("专家胶囊", style: TextStyle(color: Colors.white, fontSize: 18)),
    );
  }

  buildSay() {
    return Container(
      padding: EdgeInsets.all(16),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/say.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("今日宣言", style: TextStyle(color: Colors.white, fontSize: 18)),
          SizedBox(height: 15),
          Text(
            "爱自己\n是终身浪漫的开始\n——To Ana",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  buildSpecialday() {
    return
      GestureDetector(onTap: () => NavUtils.push(PeriodPage()),
        child: Container(
          padding: EdgeInsets.all(16),
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/specialday.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("特殊日子", style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(height: 5),
              Text(
                "当生理期前3天\n您通常会感到焦虑\n建议提前安排独处时间",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              SizedBox(height: 15),
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
      )
      ;
  }
}

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.2, size.height * 0.4),
      Offset(size.width * 0.4, size.height * 0.6),
      Offset(size.width * 0.6, size.height * 0.3),
      Offset(size.width * 0.8, size.height * 0.5),
      Offset(size.width, size.height * 0.2),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    // Draw dots at vertices
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (var point in points) {
      // Calculate radius based on height (lower y means higher position)
      // Height ranges from size.height (bottom) to 0 (top)
      // Position is size.height - point.dy
      final normalizedHeight = (size.height - point.dy) / size.height;
      final radius = 2.0 + (normalizedHeight * 3.0); // Radius between 2 and 5
      canvas.drawCircle(point, radius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SmoothLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final points = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.15, size.height * 0.3),
      Offset(size.width * 0.3, size.height * 0.7),
      Offset(size.width * 0.5, size.height * 0.2),
      Offset(size.width * 0.7, size.height * 0.6),
      Offset(size.width * 0.85, size.height * 0.4),
      Offset(size.width, size.height * 0.9),
    ];

    // 绘制渐变阴影
    final gradientPath = Path();
    gradientPath.moveTo(points[0].dx, points[0].dy);

    for (var i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);

      gradientPath.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    // 闭合路径到底部
    gradientPath.lineTo(size.width, size.height);
    gradientPath.lineTo(0, size.height);
    gradientPath.close();

    // 创建白色到透明的渐变
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(gradientPath, gradientPaint);

    // 绘制曲线
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final linePath = Path();
    linePath.moveTo(points[0].dx, points[0].dy);

    for (var i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);

      linePath.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

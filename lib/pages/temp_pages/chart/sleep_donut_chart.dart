import 'dart:math';
import 'package:flutter/material.dart';

class SleepDonutChart extends StatefulWidget {
  const SleepDonutChart({super.key});

  @override
  State<SleepDonutChart> createState() => _SleepDonutChartState();
}

class _SleepDonutChartState extends State<SleepDonutChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
        height: 220,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffE5E5E5),
            width: 1,
          ),
          color: const Color(0x63FFFFFF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x21918264),
              offset: Offset(0, 5),
              blurRadius: 3.7,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                //睡眠图表
                Icon(Icons.bed),
                Text('睡眠质量环')
              ],
            ),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: SleepRingChart(segments: [
                    RingSegment(0.2, Color(0xff19b58a)),
                    RingSegment(0.3, Color(0xff1bb5b3)),
                    RingSegment(0.3, Color(0xff3845d9)),
                    RingSegment(0.2, Color(0xff7a3fd1)),
                  ]),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Data(
                        color: Colors.green,
                        title: 'Awake',
                        value: '20%',
                        unit: '2.3h'),
                    Data(
                        color: Colors.blueAccent,
                        title: 'Awake',
                        value: '20%',
                        unit: '2.3h'),
                    Data(
                        color: Colors.deepPurple,
                        title: 'Awake',
                        value: '20%',
                        unit: '2.3h')
                  ],
                ))
              ],
            ))
          ],
        ));
  }
}

class SleepRingChart extends StatelessWidget {
  final List<RingSegment> segments;

  const SleepRingChart({super.key, required this.segments});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(220, 220),
      painter: RingPainter(segments),
      child: const Center(
        child: Text(
          "7h30m",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final List<RingSegment> segments;

  RingPainter(this.segments);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 18;

    final rect = Rect.fromCircle(center: center, radius: radius);

    const strokeWidth = 25.0;
    const gapAngle = 22; // 分段间隔角度

    double startAngle = -90; // 从顶部开始

    for (final seg in segments) {
      final sweep = seg.percent * 360 - gapAngle;

      // ⭐ 发光阴影（同色）
      final glowPaint = Paint()
        ..color = seg.color.withOpacity(0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 6
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawArc(
        rect,
        _rad(startAngle),
        _rad(sweep),
        false,
        glowPaint,
      );

      // ⭐ 主弧线
      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        _rad(startAngle),
        _rad(sweep),
        false,
        paint,
      );

      startAngle += sweep + gapAngle;
    }
  }

  double _rad(double deg) => deg * pi / 180;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Data extends StatelessWidget {
  final Color color;
  final String title;
  final String value;
  final String unit;

  const Data({
    super.key,
    required this.color,
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
            text: title,
          ),
          TextSpan(
            text: value,
          ),
          TextSpan(
            text: unit,
          )
        ]))
      ],
    );
  }
}

class RingSegment {
  final double percent;
  final Color color;

  const RingSegment(this.percent, this.color);
}

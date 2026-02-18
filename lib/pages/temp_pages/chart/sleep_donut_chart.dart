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
              Icon(Icons.bed, color: Color(0xff00a9fd), size: 20),
              const SizedBox(width: 6),
              const Text(
                '睡眠质量环',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Data(
                          color: Color(0xff19b58a),
                          title: 'Awake',
                          value: '20%',
                          unit: '1.5h',
                        ),
                        Data(
                          color: Color(0xff1bb5b3),
                          title: 'REM',
                          value: '30%',
                          unit: '2.3h',
                        ),
                        Data(
                          color: Color(0xff3845d9),
                          title: 'Light',
                          value: '30%',
                          unit: '2.3h',
                        ),
                        Data(
                          color: Color(0xff7a3fd1),
                          title: 'Deep',
                          value: '20%',
                          unit: '1.5h',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                const Text(
                  '7',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Text(
                    'h',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Text(
                  '30',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Text(
                    'm',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              '2026/02/04',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final List<RingSegment> segments;

  RingPainter(this.segments);

  static const double _strokeWidth = 25.0;
  static const double _gapAngle = 3.0;
  static const double _cornerRadius = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 18;
    final innerR = radius - _strokeWidth / 2;
    final outerR = radius + _strokeWidth / 2;

    double startAngle = -90.0;

    for (final seg in segments) {
      final sweep = seg.percent * 360 - _gapAngle;
      if (sweep <= 0) continue;

      final startRad = _degToRad(startAngle);
      final sweepRad = _degToRad(sweep);

      // 发光阴影
      final glowPath = _buildSegmentPath(
        center, innerR - 3, outerR + 3, startRad, sweepRad, _cornerRadius + 2,
      );
      canvas.drawPath(
        glowPath,
        Paint()
          ..color = seg.color.withOpacity(0.55)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
      );

      // 主弧：填充路径
      final path = _buildSegmentPath(
        center, innerR, outerR, startRad, sweepRad, _cornerRadius,
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = seg.color
          ..style = PaintingStyle.fill,
      );

      startAngle += sweep + _gapAngle;
    }
  }

  /// 构建带轻微圆角的环形扇区填充路径。
  /// 四个角各用二次贝塞尔曲线平滑过渡，cornerRadius 控制圆角大小。
  Path _buildSegmentPath(
    Offset center,
    double innerR,
    double outerR,
    double startRad,
    double sweepRad,
    double cornerRadius,
  ) {
    final endRad = startRad + sweepRad;
    final halfThick = (outerR - innerR) / 2;
    final cr = cornerRadius.clamp(0.0, halfThick);

    final outerCrAng = cr / outerR;
    final innerCrAng = cr / innerR;

    // A = 外弧起点角
    final aCorner = _polar(center, outerR, startRad);
    final aFromRadial = _polar(center, outerR - cr, startRad);
    final aToArc = _polar(center, outerR, startRad + outerCrAng);

    // B = 外弧终点角
    final bCorner = _polar(center, outerR, endRad);
    final bToRadial = _polar(center, outerR - cr, endRad);

    // C = 内弧终点角
    final cCorner = _polar(center, innerR, endRad);
    final cFromRadial = _polar(center, innerR + cr, endRad);
    final cToArc = _polar(center, innerR, endRad - innerCrAng);

    // D = 内弧起点角
    final dCorner = _polar(center, innerR, startRad);
    final dToRadial = _polar(center, innerR + cr, startRad);

    final path = Path();

    // 起点：径向线靠近 A 角（从内到外方向）
    path.moveTo(aFromRadial.dx, aFromRadial.dy);

    // 圆角 A：径向 → 外弧
    path.quadraticBezierTo(aCorner.dx, aCorner.dy, aToArc.dx, aToArc.dy);

    // 外弧 A → B（扣掉两端圆角占用的角度）
    path.arcTo(
      Rect.fromCircle(center: center, radius: outerR),
      startRad + outerCrAng,
      sweepRad - 2 * outerCrAng,
      false,
    );

    // 圆角 B：外弧 → 径向
    path.quadraticBezierTo(bCorner.dx, bCorner.dy, bToRadial.dx, bToRadial.dy);

    // 径向线 B → C（从外到内）
    path.lineTo(cFromRadial.dx, cFromRadial.dy);

    // 圆角 C：径向 → 内弧
    path.quadraticBezierTo(cCorner.dx, cCorner.dy, cToArc.dx, cToArc.dy);

    // 内弧 C → D（反向，扣掉圆角角度）
    path.arcTo(
      Rect.fromCircle(center: center, radius: innerR),
      endRad - innerCrAng,
      -(sweepRad - 2 * innerCrAng),
      false,
    );

    // 圆角 D：内弧 → 径向
    path.quadraticBezierTo(dCorner.dx, dCorner.dy, dToRadial.dx, dToRadial.dy);

    path.close();
    return path;
  }

  Offset _polar(Offset center, double r, double rad) =>
      Offset(center.dx + r * cos(rad), center.dy + r * sin(rad));

  double _degToRad(double deg) => deg * pi / 180;

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            unit,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class RingSegment {
  final double percent;
  final Color color;

  const RingSegment(this.percent, this.color);
}

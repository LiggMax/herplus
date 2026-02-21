import 'dart:math';
import 'package:flutter/material.dart';

class ActivityChart extends StatefulWidget {
  const ActivityChart({super.key});

  @override
  State<ActivityChart> createState() => _ActivityChartState();
}

class _ActivityChartState extends State<ActivityChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFD6D6D4).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(color: Colors.white, width: 0.7),
      ),
      child: Row(
        children: [
           ActivityRingChart(
              rings: [
                ActivityRing(0.85, const Color(0xFFFF8C42)), // 步数 8500/10000
                ActivityRing(0.65, const Color(0xFF9B59B6)), // 卡路里 2100/1200 超额
                ActivityRing(0.37, const Color(0xFF3498DB)), // 站立 8/12
              ],
            ),
           const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  ActivityData(
                    color: Color(0xFFFF8C42),
                    title: '步数',
                    current: '8,500',
                    target: '10,000',
                    unit: '步',
                  ),
                  ActivityData(
                    color: Color(0xFF9B59B6),
                    title: '卡路里',
                    current: '2,100',
                    target: '1,200',
                    unit: 'kcal',
                  ),
                  ActivityData(
                    color: Color(0xFF3498DB),
                    title: '站立时长',
                    current: '8',
                    target: '12',
                    unit: '小时',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityRing {
  final double percent;
  final Color color;

  const ActivityRing(this.percent, this.color);
}

class ActivityRingChart extends StatelessWidget {
  final List<ActivityRing> rings;

  const ActivityRingChart({super.key, required this.rings});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: ActivityRingPainter(rings),
    );
  }
}

class ActivityRingPainter extends CustomPainter {
  final List<ActivityRing> rings;
  static const double _strokeWidth = 8.0;
  static const double _gap = 1.5;
  static const double _cornerRadius = 5.0;

  ActivityRingPainter(this.rings);

  Offset _polar(Offset center, double r, double rad) =>
      Offset(center.dx + cos(rad) * r, center.dy + sin(rad) * r);

  Path _buildRoundedArcPath(
    Offset center,
    double innerR,
    double outerR,
    double startDeg,
    double sweepDeg,
  ) {
    final startRad = startDeg * pi / 180;
    final sweepRad = sweepDeg * pi / 180;
    final endRad = startRad + sweepRad;
    final halfThick = (outerR - innerR) / 2;
    final cr = _cornerRadius.clamp(0.0, halfThick);

    final outerCrAng = cr / outerR;
    final innerCrAng = cr / innerR;

    // A = 外弧起点角, B = 外弧终点角, C = 内弧终点角, D = 内弧起点角
    final aCorner = _polar(center, outerR, startRad);
    final aFromRadial = _polar(center, outerR - cr, startRad);
    final aToArc = _polar(center, outerR, startRad + outerCrAng);

    final bCorner = _polar(center, outerR, endRad);
    final bToRadial = _polar(center, outerR - cr, endRad);

    final cCorner = _polar(center, innerR, endRad);
    final cFromRadial = _polar(center, innerR + cr, endRad);
    final cToArc = _polar(center, innerR, endRad - innerCrAng);

    final dCorner = _polar(center, innerR, startRad);
    final dToRadial = _polar(center, innerR + cr, startRad);

    final path = Path();
    path.moveTo(aFromRadial.dx, aFromRadial.dy);
    path.quadraticBezierTo(aCorner.dx, aCorner.dy, aToArc.dx, aToArc.dy);
    path.arcTo(
      Rect.fromCircle(center: center, radius: outerR),
      startRad + outerCrAng,
      sweepRad - 2 * outerCrAng,
      false,
    );
    path.quadraticBezierTo(bCorner.dx, bCorner.dy, bToRadial.dx, bToRadial.dy);
    path.lineTo(cFromRadial.dx, cFromRadial.dy);
    path.quadraticBezierTo(cCorner.dx, cCorner.dy, cToArc.dx, cToArc.dy);
    path.arcTo(
      Rect.fromCircle(center: center, radius: innerR),
      endRad - innerCrAng,
      -(sweepRad - 2 * innerCrAng),
      false,
    );
    path.quadraticBezierTo(dCorner.dx, dCorner.dy, dToRadial.dx, dToRadial.dy);
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxRadius = size.width / 2 - 4;

    for (var i = 0; i < rings.length; i++) {
      final ring = rings[i];
      final outerR = maxRadius - i * (_strokeWidth + _gap);
      final innerR = outerR - _strokeWidth;
      final sweep = (ring.percent.clamp(0.0, 1.0) * 360).clamp(1.0, 359.0);
      const startDeg = -90.0;

      // 背景轨道（占满 360 度）
      _drawArc(
        canvas,
        center,
        innerR,
        outerR,
        startDeg,
        359.99, // 使用 359.99 避免 360° 路径退化
        ring.color.withValues(alpha: 0.25),
        blur: false,
        rounded: false,
      );

      // 主弧
      _drawArc(
        canvas,
        center,
        innerR,
        outerR,
        startDeg,
        sweep,
        ring.color,
        blur: false,
      );
    }
  }

  void _drawArc(
    Canvas canvas,
    Offset center,
    double innerR,
    double outerR,
    double startDeg,
    double sweepDeg,
    Color color, {
    bool blur = false,
    bool rounded = true,
  }) {
    final path = rounded
        ? _buildRoundedArcPath(center, innerR, outerR, startDeg, sweepDeg)
        : _buildPlainArcPath(center, innerR, outerR, startDeg, sweepDeg);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    if (blur) {
      paint.maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);
    }
    canvas.drawPath(path, paint);
  }

  Path _buildPlainArcPath(
    Offset center,
    double innerR,
    double outerR,
    double startDeg,
    double sweepDeg,
  ) {
    final startRad = startDeg * pi / 180;
    final sweepRad = sweepDeg * pi / 180;
    final path = Path();
    path.moveTo(
      center.dx + innerR * cos(startRad),
      center.dy + innerR * sin(startRad),
    );
    path.arcTo(
      Rect.fromCircle(center: center, radius: outerR),
      startRad,
      sweepRad,
      false,
    );
    path.arcTo(
      Rect.fromCircle(center: center, radius: innerR),
      startRad + sweepRad,
      -sweepRad,
      false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant ActivityRingPainter oldDelegate) =>
      oldDelegate.rings != rings;
}

class ActivityData extends StatelessWidget {
  final Color color;
  final String title;
  final String current;
  final String target;
  final String unit;

  const ActivityData({
    super.key,
    required this.color,
    required this.title,
    required this.current,
    required this.target,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF5A5A58),
                fontSize: 12,
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              style:  TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: current,
                ),
                TextSpan(text: '/$target $unit'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

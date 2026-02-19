import 'dart:math' as math;

import 'package:flutter/material.dart';

// ── 7 日趋势数据 ───────────────────────────────────────────
const _xLabels = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

/// 每日数值 (0–100)，周五=48 用于提示框「均值48」
const _values = [55.0, 25.0, 85.0, 30.0, 48.0, 70.0, 40.0];

double get _average =>
    _values.reduce((a, b) => a + b) / _values.length;

// ── Widget ────────────────────────────────────────────────
class TrendChart extends StatefulWidget {
  const TrendChart({super.key});

  @override
  State<TrendChart> createState() => _TrendChartState();
}

class _TrendChartState extends State<TrendChart> {
  /// 高亮显示的日索引，4 = 周五
  static const int _highlightIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 12, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6C605C),
            Color(0xFF5C5752),
            Color(0xFF556056),
          ],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            color: Colors.black.withValues(alpha: 0.25),
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          const Text(
            '7日趋势',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          // 图表 + Y 轴标签
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Y 轴刻度（与图表 140 高对齐）
              SizedBox(
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['100', '75', '50', '25', '0']
                      .map((t) => Text(
                            t,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(width: 8),
              // 图表绘制区
              Expanded(
                child: LayoutBuilder(
                  builder: (ctx, cs) {
                    const chartHeight = 140.0;
                    final chartWidth = cs.maxWidth;
                    return SizedBox(
                      height: chartHeight + 22,
                      child: Stack(
                        children: [
                          CustomPaint(
                            size: Size(chartWidth, chartHeight),
                            painter: _TrendChartPainter(
                              values: _values,
                              average: _average,
                              highlightIndex: _highlightIndex,
                            ),
                          ),
                          // 周五提示框：均值48
                          Positioned(
                            left: _tooltipLeft(chartWidth),
                            top: _tooltipTop(chartHeight),
                            child: _buildTooltip(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // X 轴标签
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _xLabels
                  .map((l) => Text(
                        l,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  double _tooltipLeft(double chartWidth) {
    const total = 7;
    final step = chartWidth / (total - 1);
    final x = _highlightIndex * step;
    const w = 72.0;
    double left = x - w / 2;
    if (left < 0) left = 0;
    if (left + w > chartWidth) left = chartWidth - w;
    return left;
  }

  double _tooltipTop(double chartHeight) {
    const yMin = 0.0, yMax = 100.0;
    final v = _values[_highlightIndex];
    final t = (v - yMin) / (yMax - yMin);
    final y = chartHeight * (1 - t);
    return y - 36;
  }

  Widget _buildTooltip() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF7A9FFB).withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Text(
            '均值48',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        CustomPaint(
          size: const Size(14, 8),
          painter: _TooltipArrowPainter(),
        ),
      ],
    );
  }
}

// ── 提示框下方小三角 ───────────────────────────────────────
class _TooltipArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(
      path,
      Paint()..color = const Color(0xFF7A9FFB).withValues(alpha: 0.95),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── 趋势图 CustomPainter ───────────────────────────────────
class _TrendChartPainter extends CustomPainter {
  final List<double> values;
  final double average;
  final int highlightIndex;

  const _TrendChartPainter({
    required this.values,
    required this.average,
    required this.highlightIndex,
  });

  static const _yMin = 0.0;
  static const _yMax = 100.0;
  static const _lineColor = Color(0xFF4C7AFB);
  static const _avgLineColor = Color(0xFFA5E3DE);
  static const _fillGradientStart = Color(0xFF2A4A5A);
  static const _fillGradientEnd = Color(0xFF5B9BD5);
  static const _highlightStroke = Color(0xFF6CC7F0);

  @override
  void paint(Canvas canvas, Size size) {
    final pts = _points(size);
    final path = _smoothPath(pts);

    // 1. 曲线下方渐变填充
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    final fillRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [_fillGradientStart, _fillGradientEnd.withValues(alpha: 0.6)],
        ).createShader(fillRect),
    );

    // 2. 平均值水平虚线
    final avgT = (average - _yMin) / (_yMax - _yMin);
    final avgY = size.height * (1 - avgT);
    _drawDashedHorizontalLine(canvas, avgY, size.width);

    // 3. 主趋势线
    canvas.drawPath(
      path,
      Paint()
        ..color = _lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..isAntiAlias = true,
    );

    // 4. 高亮数据点（周五）：白心 + 浅蓝描边
    if (highlightIndex >= 0 && highlightIndex < pts.length) {
      final p = pts[highlightIndex];
      canvas.drawCircle(p, 7, Paint()..color = _highlightStroke);
      canvas.drawCircle(p, 5, Paint()..color = Colors.white);
    }
  }

  List<Offset> _points(Size size) {
    final w = size.width;
    final h = size.height;
    final n = values.length;
    final step = n > 1 ? w / (n - 1) : 0.0;
    return List.generate(n, (i) {
      final t = (values[i] - _yMin) / (_yMax - _yMin);
      final y = h * (1 - t.clamp(0.0, 1.0));
      return Offset(i * step, y);
    });
  }

  Path _smoothPath(List<Offset> pts) {
    if (pts.isEmpty) return Path();
    if (pts.length == 1) return Path()..moveTo(pts[0].dx, pts[0].dy);
    final path = Path()..moveTo(pts[0].dx, pts[0].dy);
    for (int i = 0; i < pts.length - 1; i++) {
      final p0 = pts[i > 0 ? i - 1 : i];
      final p1 = pts[i];
      final p2 = pts[i + 1];
      final p3 = pts[i < pts.length - 2 ? i + 2 : i + 1];
      final cp1 = Offset(
        p1.dx + (p2.dx - p0.dx) / 6,
        p1.dy + (p2.dy - p0.dy) / 6,
      );
      final cp2 = Offset(
        p2.dx - (p3.dx - p1.dx) / 6,
        p2.dy - (p3.dy - p1.dy) / 6,
      );
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
    }
    return path;
  }

  void _drawDashedHorizontalLine(Canvas canvas, double y, double width) {
    const dash = 6.0;
    const gap = 4.0;
    final paint = Paint()
      ..color = _avgLineColor
      ..strokeWidth = 1.5;
    double x = 0;
    bool draw = true;
    while (x < width) {
      final next = math.min(x + (draw ? dash : gap), width);
      if (draw) canvas.drawLine(Offset(x, y), Offset(next, y), paint);
      x = next;
      draw = !draw;
    }
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter old) =>
      old.values != values || old.average != average || old.highlightIndex != highlightIndex;
}

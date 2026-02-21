import 'dart:math' as math;

import 'package:flutter/material.dart';

// ── 情绪定义 ─────────────────────────────────────────────
class _Emotion {
  final String name;
  final Color color;
  final double baseY; // 线条中心纵向位置（0=顶部, 1=底部）
  final double phase; // 正弦波相位
  final double amplitude; // 正弦振幅（纵向）
  final double basePct; // 基础百分比（用于 tooltip）

  const _Emotion({
    required this.name,
    required this.color,
    required this.baseY,
    required this.phase,
    this.amplitude = 0.030,
    required this.basePct,
  });

  /// 第 h 小时的 Y 坐标（归一化）
  double yAt(int h) =>
      baseY + amplitude * math.sin(2 * math.pi * h / 24 + phase);

  /// 第 h 小时的百分比（整数）
  int pctAt(int h) {
    final v = basePct *
        100 *
        (1 + 0.12 * math.sin(2 * math.pi * h / 24 + phase + 0.8));
    return v.round().clamp(0, 100);
  }
}

//  数据
const _emotions = [
  _Emotion(
      name: '平静',
      color: Color(0xFF9B59B6),
      baseY: 0.11,
      phase: 0.5,
      basePct: 0.40),
  _Emotion(
      name: '愉悦',
      color: Color(0xFFE53935),
      baseY: 0.25,
      phase: 1.8,
      basePct: 0.28),
  _Emotion(
      name: '惊奇',
      color: Color(0xFF64B5F6),
      baseY: 0.39,
      phase: 0.3,
      basePct: 0.10,
      amplitude: 0.025),
  _Emotion(
      name: '厌恶',
      color: Color(0xFF66BB6A),
      baseY: 0.52,
      phase: 2.2,
      basePct: 0.04,
      amplitude: 0.022),
  _Emotion(
      name: '悲伤',
      color: Color(0xFF1E88E5),
      baseY: 0.64,
      phase: 1.0,
      basePct: 0.04,
      amplitude: 0.022),
  _Emotion(
      name: '愤怒',
      color: Color(0xFFFF7043),
      baseY: 0.76,
      phase: 2.8,
      basePct: 0.02,
      amplitude: 0.018),
  _Emotion(
      name: '恐惧',
      color: Color(0xFFFFD740),
      baseY: 0.88,
      phase: 0.9,
      basePct: 0.01,
      amplitude: 0.014),
];

const _xLabels = ['00:00', '06:00', '12:00', '18:00', '24:00'];

class EmotionalWeatherChart extends StatefulWidget {
  const EmotionalWeatherChart({super.key});

  @override
  State<EmotionalWeatherChart> createState() => _EmotionalWeatherChartState();
}

class _EmotionalWeatherChartState extends State<EmotionalWeatherChart> {
  double? _tapX; // 归一化 0-1

  int get _selectedHour =>
      _tapX == null ? -1 : (_tapX! * 24).round().clamp(0, 24);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        children: [
          // 图表区域
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 180,
            child: LayoutBuilder(
              builder: (ctx, cs) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (d) => setState(
                  () => _tapX =
                      (d.localPosition.dx / cs.maxWidth).clamp(0.0, 1.0),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomPaint(
                      size: Size(cs.maxWidth, cs.maxHeight),
                      painter: _ChartPainter(tapX: _tapX),
                    ),
                    if (_tapX != null) _buildTooltip(cs),
                  ],
                ),
              ),
            ),
          ),
          // X 轴
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _xLabels
                  .map((l) => Text(
                        l,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ))
                  .toList(),
            ),
          ),
          // 图例
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _emotions
                  .map(
                    (e) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: e.color),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          e.name,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 工具提示
  Widget _buildTooltip(BoxConstraints cs) {
    final hour = _selectedHour;
    final timeStr = '${hour.toString().padLeft(2, '0')}:00';
    const w = 120.0;
    final tapPx = (_tapX ?? 0) * cs.maxWidth;

    double left = tapPx + 10;
    if (left + w > cs.maxWidth) left = tapPx - w - 13;
    left = left.clamp(0, cs.maxWidth - w);

    return Positioned(
      left: left,
      top: 10,
      child: Container(
        width: w,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(14),
          border:
              Border.all(width: 1.5, color: Colors.white.withValues(alpha: 0.6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              timeStr,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
            ..._emotions.map(
              (e) =>  Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: e.color)),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        e.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Text(
                      '${e.pctAt(hour)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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
}

// ── Painter ───────────────────────────────────────────────
class _ChartPainter extends CustomPainter {
  final double? tapX;

  const _ChartPainter({this.tapX});

  @override
  void paint(Canvas canvas, Size size) {
    // 先从下到上绘制填充（让上层覆盖下层，保持层次感）
    for (final e in _emotions.reversed) {
      _drawFill(canvas, size, e);
    }

    // 再绘制各情绪曲线
    for (final e in _emotions) {
      _drawLine(canvas, size, e);
    }

    // 竖向虚线 + 交叉点圆点
    if (tapX != null) {
      final x = tapX! * size.width;
      _drawDashedLine(canvas, x, size.height);

      final hour = (tapX! * 24).round().clamp(0, 24);
      for (final e in _emotions) {
        final y = e.yAt(hour) * size.height;
        canvas.drawCircle(
            Offset(x, y), 5.5, Paint()..color = Colors.white.withOpacity(0.9));
        canvas.drawCircle(Offset(x, y), 3.8, Paint()..color = e.color);
      }
    }
  }

  List<Offset> _pts(Size size, _Emotion e) => List.generate(
      25, (h) => Offset(h / 24 * size.width, e.yAt(h) * size.height));

  void _drawFill(Canvas canvas, Size size, _Emotion e) {
    final pts = _pts(size, e);
    final linePath = _smoothPath(pts);

    final fillPath = Path.from(linePath)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    // 渐变从线条位置开始，向下衰减到透明
    final startY = e.baseY * size.height;
    final fillRect = Rect.fromLTWH(0, startY, size.width, size.height - startY);

    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // 横向线条色填充
    canvas.drawPath(fillPath, Paint()..color = e.color.withOpacity(0.45));

    // 纵向透明度遮罩：从 startY 处不透明 → 底部透明
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..blendMode = BlendMode.dstIn
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white.withOpacity(0.55), Colors.transparent],
        ).createShader(fillRect),
    );

    canvas.restore();
  }

  void _drawLine(Canvas canvas, Size size, _Emotion e) {
    canvas.drawPath(
      _smoothPath(_pts(size, e)),
      Paint()
        ..color = e.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  void _drawDashedLine(Canvas canvas, double x, double height) {
    final paint = Paint()
      ..color = Colors.white60
      ..strokeWidth = 1.4;
    const dash = 6.0;
    const gap = 4.0;
    double y = 0;
    bool draw = true;
    while (y < height) {
      final next = math.min(y + (draw ? dash : gap), height);
      if (draw) canvas.drawLine(Offset(x, y), Offset(x, next), paint);
      y = next;
      draw = !draw;
    }
  }

  /// Catmull-Rom → Cubic Bezier，切线考虑前后两点，消除直角折线
  Path _smoothPath(List<Offset> pts) {
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 0; i < pts.length - 1; i++) {
      final p0 = pts[i > 0 ? i - 1 : i];
      final p1 = pts[i];
      final p2 = pts[i + 1];
      final p3 = pts[i < pts.length - 2 ? i + 2 : i + 1];

      final cp1 =
          Offset(p1.dx + (p2.dx - p0.dx) / 6, p1.dy + (p2.dy - p0.dy) / 6);
      final cp2 =
          Offset(p2.dx - (p3.dx - p1.dx) / 6, p2.dy - (p3.dy - p1.dy) / 6);

      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant _ChartPainter old) => old.tapX != tapX;
}

import 'package:flutter/material.dart';

class FancyLineChart extends StatelessWidget {
  const FancyLineChart({super.key});

  static const _yLabels = ['100', '75', '50', '25'];
  static const _xLabels = ['00:00', '06:00', '12:00', '18:00', '24:00'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
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
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SizedBox(
        height: 220,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Y 轴标签列
            _YAxisLabels(labels: _yLabels),
            const SizedBox(width: 6),
            // 图表 + X 轴标签
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: CustomPaint(
                      painter: _LineChartPainter(),
                      child: const SizedBox.expand(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  _XAxisLabels(labels: _xLabels),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _YAxisLabels extends StatelessWidget {
  final List<String> labels;
  const _YAxisLabels({required this.labels});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // 底部留出和 X 轴标签等高的空间让 Y 标签对齐图表区
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: labels
            .map(
              (l) => Text(
                l,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _XAxisLabels extends StatelessWidget {
  final List<String> labels;
  const _XAxisLabels({required this.labels});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: labels
          .map(
            (l) => Text(
              l,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          )
          .toList(),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  // 线条渐变色（左→右）
  static const _lineColors = [
    Color(0xFF5CF0C7),
    Color(0xFFFFA726),
    Color(0xFFEC407A),
    Color(0xFFAB47BC),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final points = [
      Offset(0, size.height * 0.68),
      Offset(size.width * 0.18, size.height * 0.82),
      Offset(size.width * 0.45, size.height * 0.18),
      Offset(size.width * 0.65, size.height * 0.52),
      Offset(size.width, size.height * 0.32),
    ];

    final path = _smoothPath(points);
    final rect = Offset.zero & size;

    // 线条渐变 shader
    final lineGradient = LinearGradient(colors: _lineColors)
        .createShader(rect);

    // 底部填充：颜色与线条一致，纵向由不透明→透明
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    // 用线条各色叠加纵向 alpha 衰减来实现"跟线同色"的填充
    // 方案：横向渐变 + 纵向透明度遮罩
    canvas.saveLayer(rect, Paint());

    // 先画横向渐变底色
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(colors: _lineColors).createShader(rect),
    );

    // 再用纵向透明度遮罩让底部消隐
    canvas.drawRect(
      rect,
      Paint()
        ..blendMode = BlendMode.dstIn
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0.45),
            Colors.transparent,
          ],
          stops: const [0.0, 1.0],
        ).createShader(rect),
    );

    canvas.restore();

    // 主曲线
    canvas.drawPath(
      path,
      Paint()
        ..shader = lineGradient
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
  }

  Path _smoothPath(List<Offset> pts) {
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 0; i < pts.length - 1; i++) {
      final p0 = pts[i];
      final p1 = pts[i + 1];
      final cx = (p0.dx + p1.dx) / 2;
      path.cubicTo(cx, p0.dy, cx, p1.dy, p1.dx, p1.dy);
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

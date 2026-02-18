import 'dart:ui';
import 'package:flutter/material.dart';

class GlassPill extends StatelessWidget {
  final String text;

  const GlassPill({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GlassBorderPainter(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),

            // ⭐ 玻璃底渐变
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFD9C8),
                Color(0xFFE3A7B3),
              ],
            ),

            // ⭐ 外阴影（悬浮感）
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              )
            ],
          ),

          child: Stack(
            children: [
              // ⭐ 内阴影（拟物关键）
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 20,
                        spreadRadius: -8,
                        offset: const Offset(6, 8),
                      )
                    ],
                  ),
                ),
              ),

              // ⭐ 顶部玻璃反射（柔光）
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.white.withOpacity(0.55),
                          Colors.white.withOpacity(0.15),
                          Colors.transparent,
                        ],
                        stops: const [0, 0.35, 1],
                      ),
                    ),
                  ),
                ),
              ),

              // ⭐ 模糊光斑（真实反射）
              Positioned(
                top: 6,
                left: 20,
                right: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      height: 20,
                      color: Colors.white.withOpacity(0.15),
                    ),
                  ),
                ),
              ),

              // ⭐ 文字
              Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(size.height / 2),
    );

    final path = Path()..addRRect(rrect);
    final metric = path.computeMetrics().first;
    final length = metric.length;

    // ⭐ 主高光线
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // ⭐ 模糊光晕（更真实）
    final glow = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // 左上弧
    final topLeft = metric.extractPath(0, length * 0.22);

    // 右下弧
    final bottomRight = metric.extractPath(length * 0.58, length * 0.82);

    canvas.drawPath(topLeft, glow);
    canvas.drawPath(bottomRight, glow);

    canvas.drawPath(topLeft, paint);
    canvas.drawPath(bottomRight, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


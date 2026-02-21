import 'dart:math' as math;
import 'package:flutter/material.dart';

class HealthCondition extends StatefulWidget {
  const HealthCondition({super.key});

  @override
  State<HealthCondition> createState() => _HealthConditionState();
}

class _HealthConditionState extends State<HealthCondition> {
  /// 恢复分数 0-100
  static const int _score = 79;
  static const String _status = '良好';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withValues(alpha: 0.5),
        boxShadow: [
          // 底部/右侧深色外阴影，营造浮起感
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            offset: const Offset(4, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildLeftContent(),
          ),
          _buildRightRingProgress(),
        ],
      ),
    );
  }

  Widget _buildLeftContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '你的恢复情况',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _status,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE8A54B),
          ),
        ),
        const SizedBox(height: 6),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '适合',
              ),
              TextSpan(
                text: '中等强度',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )
              ),
              TextSpan(
                text: '活动',
              )
            ]
          ),
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildRightRingProgress() {
    const double size = 90;
    const double strokeWidth = 10;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(size, size),
            painter: _RecoveryRingPainter(
              progress: _score / 100,
              strokeWidth: strokeWidth,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '分数',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$_score',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE8A54B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 半圆弧形进度条，橘红到亮黄渐变色
class _RecoveryRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  _RecoveryRingPainter({
    required this.progress,
    this.strokeWidth = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // C 形弧：从左侧经底部到右侧，缺口在右上方
    const double startAngle = 180; // 从左侧开始
    const double totalSweep = 270; // 270° 弧，留 90° 缺口在右上

    final bgPaint = Paint()
      ..color = const Color(0xFFBDBDBD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, _degToRad(startAngle), _degToRad(totalSweep), false, bgPaint);

    // 绘制填充的渐变色弧（橘红→橙黄→亮黄）
    final sweepAngle = totalSweep * progress;
    if (sweepAngle > 0) {
      final gradientPaint = Paint()
        ..shader = SweepGradient(
          center: Alignment.center,
          startAngle: _degToRad(startAngle),
          endAngle: _degToRad(startAngle + totalSweep),
          colors: const [
            Color(0xFFE87040),
            Color(0xFFE8A54B),
            Color(0xFFF5D76E),
          ],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, _degToRad(startAngle), _degToRad(sweepAngle), false, gradientPaint);
    }
  }

  double _degToRad(double deg) => deg * math.pi / 180;

  @override
  bool shouldRepaint(covariant _RecoveryRingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.strokeWidth != strokeWidth;
}

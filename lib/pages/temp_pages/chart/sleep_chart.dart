import 'package:flutter/material.dart';

class SleepChart extends StatefulWidget {
  const SleepChart({super.key});

  @override
  State<SleepChart> createState() => _SleepChartState();
}

class _SleepChartState extends State<SleepChart> {
  //  24 小时睡眠柱状数据（0-24 每半小时或 1 小时一个点）
  // 值表示柱子的相对高度（0-1），颜色表示睡眠阶段
  final List<_SleepBar> _bars = const [
    _SleepBar(height: 0.7, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.5, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.3, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.6, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.4, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.8, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.5, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.3, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.7, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.4, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.9, color: Color(0xFF244BFF)), // 深睡
    _SleepBar(height: 0.2, color: Color(0xFFFF4B4B)), // 清醒
    _SleepBar(height: 0.6, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.6, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.5, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.5, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.4, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.4, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.5, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.5, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.6, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.6, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.7, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.7, color: Color(0xFF35D2C3)),
  ];

  // 紫色进度条的进度（0-1），对应时间轴上的位置
  double _progress = 0.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Color(0xFFE5E5E5),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 8),
          _buildCloud(),
          const SizedBox(height: 8),
          _buildBars(),
          _buildProgressBar(),
          const SizedBox(height: 6),
          _buildTimeAxis(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xFF9C6BFF),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.nightlight_round,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              '今日睡眠',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          children: const [
            Text(
              '8h12m',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4),
            Text(
              '85分',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCloud() {
    return Expanded(
      child: Center(
        child: Image.asset(
          'assets/images/cloud.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBars() {
    return SizedBox(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(_bars.length, (index) {
          final bar = _bars[index];
          return Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 20 + bar.height * 50, // 最小高度 20，最大约 70
                decoration: BoxDecoration(
                  color: bar.color,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProgressBar() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null) return;
        final localPos = box.globalToLocal(details.globalPosition);
        final width = box.size.width - 32; // 左右 padding 16
        final dx = (localPos.dx - 16).clamp(0.0, width);
        setState(() {
          _progress = width == 0 ? 0 : dx / width;
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final trackWidth = constraints.maxWidth;
          final activeWidth = trackWidth * _progress;

          return SizedBox(
            height: 24,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                // 底层浅灰进度条
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                // 紫色高亮进度条
                Container(
                  height: 10,
                  width: activeWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF9C6BFF),
                        Color(0xFFB86CFF),
                      ],
                    ),
                  ),
                ),
                // 圆形滑块（直径 20，会上下各溢出 5px）
                Positioned(
                  left: activeWidth - 10,
                  top: 2, // 垂直居中到高度为 10 的进度条上
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeAxis() {
    const style = TextStyle(
      color: Colors.black54,
      fontSize: 10,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('00:00', style: style),
        Text('06:00', style: style),
        Text('12:00', style: style),
        Text('18:00', style: style),
        Text('24:00', style: style),
      ],
    );
  }
}

class _SleepBar {
  final double height;
  final Color color;

  const _SleepBar({
    required this.height,
    required this.color,
  });
}

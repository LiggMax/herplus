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
    _SleepBar(height: 0.5, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.3, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.7, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.7, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.4, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.8, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.5, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.3, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.7, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.7, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.7, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.7, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.4, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.9, color: Color(0xFF244BFF)), // 深睡
    _SleepBar(height: 0.2, color: Color(0xFFFF4B4B)), // 清醒
    _SleepBar(height: 0.2, color: Color(0xFFFF4B4B)), // 清醒
    _SleepBar(height: 0.2, color: Color(0xFFFF4B4B)), // 清醒
    _SleepBar(height: 0.3, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.7, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.7, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.7, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.7, color: Color(0xFF9C6BFF)),
    _SleepBar(height: 0.5, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.5, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.5, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.5, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.6, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.6, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.7, color: Color(0xFF35D2C3)),
    _SleepBar(height: 0.7, color: Color(0xFF35D2C3)),
  ];

  // 紫色进度条的进度（0-1），对应时间轴上的位置
  double _progress = 0.5;

  /// 当前选中的柱子索引，默认选中中间
  int? _selectedIndex;

  int get _effectiveSelectedIndex =>
      _selectedIndex ?? (_bars.length ~/ 2).clamp(0, _bars.length - 1);


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
    const barHeight = 70.0;
    const circleSize = 16.0;
    const circleInnerSize = 6.0;
    const selectedBarsOpacity = 0.35;

    return LayoutBuilder(
      builder: (context, constraints) {

        return SizedBox(
          height: barHeight + circleSize + 36, // 柱子 + 底部圆圈 + 气泡高度
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(_bars.length, (index) {
              final bar = _bars[index];
              final isSelected = index == _effectiveSelectedIndex;
              final reduceOpacity = index > _effectiveSelectedIndex;
              final barHeightValue = 20 + bar.height * 50;

              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          clipBehavior: Clip.none,
                          children: [
                            // 柱子
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              height: barHeightValue,
                              decoration: BoxDecoration(
                                color: reduceOpacity
                                    ? bar.color
                                        .withValues(alpha: selectedBarsOpacity)
                                    : bar.color,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                ),
                              ),
                            ),
                            // 底部圆圈选中效果
                            Positioned(
                              bottom: -5,
                              child: SizedBox(
                                height: circleSize,
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: circleSize,
                                          height: circleSize,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 5,
                                              color: Colors.white
                                                  .withValues(alpha: 0.8),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: bar.color
                                                    .withValues(alpha: 0.5),
                                                blurRadius: 8,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: circleInnerSize,
                                              height: circleInnerSize,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: bar.color,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
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
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white.withValues(alpha: 0.5),
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
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                            top: -30,
                            child: Container(
                              padding: EdgeInsets.only(top:3),
                              alignment: Alignment.topCenter,
                              width: 60,
                              height: 70,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  'assets/images/bubble/purple_bubble.png',
                                ),
                              )),
                              child: Text(
                                '浅睡',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )),
                        Container(
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
                      ],
                    )),
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

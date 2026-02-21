import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../heart_rate_chart_helper.dart';

class HeartRateGraph extends StatefulWidget {
  const HeartRateGraph({super.key});

  @override
  State<HeartRateGraph> createState() => _HeartRateGraphState();
}

class _HeartRateGraphState extends State<HeartRateGraph> {
  // 生成24小时心率数据
  List<FlSpot> get _heartRateData {
    return [
      FlSpot(0, 72), // 00:00 - 70-75 bpm
      FlSpot(1, 70),
      FlSpot(2, 65),
      FlSpot(3, 62),
      FlSpot(4, 60), // 04:00 - 最低值 60 bpm
      FlSpot(5, 62),
      FlSpot(6, 65),
      FlSpot(7, 70),
      FlSpot(8, 72),
      FlSpot(9, 75),
      FlSpot(10, 78),
      FlSpot(11, 82),
      FlSpot(12, 85),
      FlSpot(13, 88),
      FlSpot(14, 92),
      FlSpot(15, 96),
      FlSpot(16, 100),
      FlSpot(17, 105),
      FlSpot(18, 112),
      FlSpot(19, 120),
      FlSpot(20, 128), // 20:00 - 峰值 128 bpm
      FlSpot(21, 118),
      FlSpot(22, 105),
      FlSpot(23, 95),
      FlSpot(24, 85),
    ];
  }

  // 找到最低点和最高点
  FlSpot get _minSpot {
    return _heartRateData.reduce((a, b) => a.y < b.y ? a : b);
  }

  FlSpot get _maxSpot {
    return _heartRateData.reduce((a, b) => a.y > b.y ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 222,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3A2A2A), Color(0xFF2F3E2A)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/heart_rate_icon.png',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '24小时心率趋势',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset('assets/icons/avg.png', width: 16, height: 16),
                  const SizedBox(width: 8),
                  const Text(
                    '5 min average',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // 实现保持一致的留白，确保坐标轴与标签对齐
                  const leftReserved = 35.0;
                  const bottomReserved = 30.0;
                  const double minX = 0, maxX = 24, minY = 40, maxY = 160;

                  final chartWidth = constraints.maxWidth - leftReserved;
                  final chartHeight = constraints.maxHeight - bottomReserved;

                  final maxSpot = _maxSpot;
                  final minSpot = _minSpot;

                  final maxPixelX = leftReserved +
                      (maxSpot.x - minX) / (maxX - minX) * chartWidth;
                  final maxPixelY =
                      (1 - (maxSpot.y - minY) / (maxY - minY)) * chartHeight;

                  final minPixelX = leftReserved +
                      (minSpot.x - minX) / (maxX - minX) * chartWidth;
                  final minPixelY =
                      (1 - (minSpot.y - minY) / (maxY - minY)) * chartHeight;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      LineChart(
                        LineChartData(
                          minY: 40,
                          maxY: 160,
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            drawHorizontalLine: true,
                            verticalInterval: 6,
                            horizontalInterval: 40,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.white.withOpacity(0.1),
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 35,
                                interval: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  );
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval: 6,
                                getTitlesWidget: (value, meta) {
                                  if (value % 6 == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        '${value.toInt().toString().padLeft(2, '0')}:00',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            ...HeartRateChartHelper.buildSegmentedLineBars(
                              _heartRateData,
                              threshold: 80,
                              belowColor: const Color(0xFFFF8F41),
                              aboveColor: Colors.white,
                            ),
                          ],
                          lineTouchData: const LineTouchData(enabled: false),
                        ),
                      ),
                      // 最高点圆点
                      Positioned(
                        left: maxPixelX - 5,
                        top: maxPixelY - 5,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // 最低点圆点（橙色描边，内部透明）
                      Positioned(
                        left: minPixelX - 5,
                        top: minPixelY - 5,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            color: const Color(0xFFFF8F41),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // 最高点标签
                      Positioned(
                        left: maxPixelX - 45 / 2,
                        top: maxPixelY - 43,
                        child: _buildIndicator(
                          value: maxSpot.y.toInt(),
                          hour: maxSpot.x.toInt(),
                          backgroundColor: const Color(0xFF6FA0E1),
                          image: 'assets/images/indicator.png',
                        ),
                      ),
                      // 最低点标签
                      Positioned(
                        left: minPixelX - 45 / 2,
                        top: minPixelY - 44,
                        child: _buildIndicator(
                          value: minSpot.y.toInt(),
                          hour: minSpot.x.toInt(),
                          backgroundColor: const Color(0xFFF3BACE),
                          image: 'assets/images/Rectangle.png',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 通用的高/低点标签
  Widget _buildIndicator({
    required int value,
    required int hour,
    required Color backgroundColor,
    required String image,
  }) {
    return Container(
      width: 45,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 4),
          Text(
            '$value',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          Text(
            '${hour.toString().padLeft(2, '0')}:00',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TrendChart extends StatefulWidget {
  const TrendChart({super.key});

  @override
  State<TrendChart> createState() => _TrendChartState();
}

class _TrendChartState extends State<TrendChart> {
  static const _weekDays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

  // 7 日趋势数据 (周一至周日)
  List<FlSpot> get _trendData {
    return [
      const FlSpot(0, 35),
      const FlSpot(1, 55),
      const FlSpot(2, 42),
      const FlSpot(3, 68),
      const FlSpot(4, 48), // 周五，均值 48
      const FlSpot(5, 72),
      const FlSpot(6, 88),
    ];
  }

  static const _meanValue = 50.0;
  int _selectedSpotIndex = 4; // 默认选中周五

  LineChartBarData _buildLineBarData() {
    return LineChartBarData(
      spots: _trendData,
      isCurved: true,
      preventCurveOverShooting: true,
      color: const Color(0xFF3848FD),
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        checkToShowDot: (spot, barData) => false,
        getDotPainter: (spot, percent, barData, index) =>
            FlDotCirclePainter(radius: 4, color: Colors.transparent),
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF6FA0E1).withValues(alpha: 0.35),
            const Color(0xFF6FA0E1).withValues(alpha: 0.15),
            const Color(0xFF4A6B8A).withValues(alpha: 0.08),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3B2C2C), Color(0xFF4F5D4D)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '7日趋势',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const leftReserved = 35.0;
                  const bottomReserved = 30.0;
                  const double minX = 0, maxX = 6, minY = 0, maxY = 100;

                  final chartWidth = constraints.maxWidth - leftReserved;
                  final chartHeight = constraints.maxHeight - bottomReserved;

                  final lineBarData = _buildLineBarData();
                  final idx = _selectedSpotIndex.clamp(
                    0,
                    lineBarData.spots.length - 1,
                  );
                  final spot = lineBarData.spots[idx];

                  final spotPixelX = leftReserved +
                      (spot.x - minX) / (maxX - minX) * chartWidth;
                  final spotPixelY =
                      (1 - (spot.y - minY) / (maxY - minY)) * chartHeight;

                  const bubbleW = 60.0;
                  const bubbleH = 50.0;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      LineChart(
                        LineChartData(
                          minX: minX,
                          maxX: maxX,
                          minY: minY,
                          maxY: maxY,
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            drawHorizontalLine: true,
                            horizontalInterval: 25,
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
                                reservedSize: leftReserved,
                                interval: 25,
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
                                reservedSize: bottomReserved,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  final i = value.toInt();
                                  if (i >= 0 && i < _weekDays.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        _weekDays[i],
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
                          extraLinesData: ExtraLinesData(
                            horizontalLines: [
                              HorizontalLine(
                                y: _meanValue,
                                color: const Color(0xFF3AD5FD)
                                    .withValues(alpha: 0.8),
                                strokeWidth: 1.1,
                                dashArray: [3, 3],
                              ),
                            ],
                          ),
                          lineBarsData: [lineBarData],
                          lineTouchData: LineTouchData(
                            enabled: true,
                            handleBuiltInTouches: false,
                            touchCallback: (event, response) {
                              if (response != null &&
                                  response.lineBarSpots != null &&
                                  response.lineBarSpots!.isNotEmpty) {
                                final touched = response.lineBarSpots!.first;
                                setState(() {
                                  _selectedSpotIndex = touched.spotIndex;
                                });
                              }
                            },
                            getTouchedSpotIndicator: (LineChartBarData barData,
                                List<int> spotIndexes) {
                              return spotIndexes.map((index) {
                                return TouchedSpotIndicatorData(
                                  FlLine(
                                      color: Colors.transparent,
                                      strokeWidth: 0),
                                  FlDotData(show: false),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        duration: const Duration(milliseconds: 150),
                      ),
                      // 选中点白色圆点
                      Positioned(
                        left: spotPixelX - 5,
                        top: spotPixelY - 5,
                        child: IgnorePointer(
                          child: Container(
                            alignment: Alignment.center,
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2, color: const Color(0xFF6FA0E1)),
                            ),
                          ),
                        ),
                      ),
                      // 气泡标签
                      Positioned(
                        left: spotPixelX - 70 / 2,
                        top: spotPixelY - bubbleH + 5,
                        child: IgnorePointer(
                          child: Container(
                            padding: const EdgeInsets.only(top: 5),
                            width: bubbleW + 10,
                            height: bubbleH,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                alignment: Alignment.topCenter,
                                image: AssetImage(
                                    'assets/images/bubble/blue_bubble.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.topCenter,
                            child: Text(
                              '均值 ${spot.y.toInt()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
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
}

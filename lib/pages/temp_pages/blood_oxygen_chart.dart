import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BloodOxygenChart extends StatefulWidget {
  const BloodOxygenChart({super.key});

  @override
  State<BloodOxygenChart> createState() => _BloodOxygenChartState();
}

class _BloodOxygenChartState extends State<BloodOxygenChart> {
  // 生成24小时夜间血氧数据（基于图片描述）
  // 数据在90-100之间波动，最低点约88-90，最高点接近100
  List<FlSpot> get _oxygenData {
    return [
      const FlSpot(0, 95), // 00:00 - 约95
      const FlSpot(1, 93),
      const FlSpot(2, 91),
      const FlSpot(3, 89),
      const FlSpot(4, 88), // 04:00 - 最低点约88
      const FlSpot(5, 90),
      const FlSpot(6, 98), // 06:00 - 峰值接近100
      const FlSpot(7, 96),
      const FlSpot(8, 94),
      const FlSpot(9, 92),
      const FlSpot(10, 90),
      const FlSpot(11, 92),
      const FlSpot(12, 95), // 12:00 - 约95
      const FlSpot(13, 93),
      const FlSpot(14, 91),
      const FlSpot(15, 89),
      const FlSpot(16, 92),
      const FlSpot(17, 94),
      const FlSpot(18, 95), // 18:00 - 约95
      const FlSpot(19, 93),
      const FlSpot(20, 91),
      const FlSpot(21, 92),
      const FlSpot(22, 94),
      const FlSpot(23, 96),
      const FlSpot(24, 95), // 24:00 - 约95
    ];
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/night.png',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '夜间血氧',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
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
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 24,
                  minY: 80,
                  maxY: 100,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: true,
                    verticalInterval: 6,
                    horizontalInterval: 10,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white.withOpacity(0.1),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
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
                        interval: 10,
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
                    LineChartBarData(
                      spots: _oxygenData,
                      isCurved: true,
                      curveSmoothness: 0.35,
                      preventCurveOverShooting: true,
                      color: const Color(0xFF978EED),
                      // 浅紫色/薰衣草色
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF978EED).withValues(alpha: 0.4),
                            const Color(0xFF978EED).withValues(alpha: 0.2),
                            const Color(0xFF978EED).withValues(alpha: 0.1),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.3, 0.6, 1.0],
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: const LineTouchData(enabled: false),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class IntensityDistributionChart extends StatefulWidget {
  const IntensityDistributionChart({super.key});

  @override
  State<IntensityDistributionChart> createState() =>
      _IntensityDistributionChartState();
}

class _IntensityDistributionChartState
    extends State<IntensityDistributionChart> {
  static const _sedentaryColor = Color(0xFFEA8482);   // 久坐 橙
  static const _lightColor = Color(0xFF2A87E4);       // 轻度 蓝
  static const _modHighColor = Color(0xFF9169E4);     // 中高强度 紫

  static const _timeLabels = ['06:00', '10:00', '14:00', '18:00', '20:00', '22:00'];

  // 每组 [久坐, 轻度, 中高强度] 的 METs 值
  static const _data = [
    [22.0, 72.0, 61.0],   // 06:00
    [22.0, 50.0, 30.0],   // 10:00
    [22.0, 56.0, 84.0],  // 14:00
    [22.0, 50.0, 50.0],   // 18:00
    [100.0, 32.0, 84.0],   // 20:00
    [38.0, 56.0, 99.0],   // 22:00
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFD6D6D4).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(color: Colors.white, width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题与图例
          Row(
            children: [
              const Text(
                'METs',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A5A58),
                ),
              ),
              const Spacer(),
              _buildLegendItem(_sedentaryColor, '久坐'),
              const SizedBox(width: 8),
              _buildLegendItem(_lightColor, '轻度'),
              const SizedBox(width: 8),
              _buildLegendItem(_modHighColor, '中高强度'),
            ],
          ),
          const SizedBox(height: 8),
          // 图表区域
           Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
              child: BarChart(
                BarChartData(
                  minY: 0,
                  maxY: 100,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    drawHorizontalLine: true,
                    horizontalInterval: 23,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.black12.withValues(alpha: 0.05),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 20,
                        interval: 25,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Color(0xFF787877),
                              fontSize: 10,
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
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          if (i >= 0 && i < _timeLabels.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                _timeLabels[i],
                                style: const TextStyle(
                                  color: Color(0xFF8A8A88),
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
                  alignment: BarChartAlignment.spaceEvenly,
                  groupsSpace: 22,
                  barGroups: _data.asMap().entries.map((entry) {
                    final i = entry.key;
                    final vals = entry.value;
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          fromY: 0,
                          toY: vals[0],
                          color: _sedentaryColor,
                          width: 10,
                          borderRadius: BorderRadius.zero,
                        ),
                        BarChartRodData(
                          fromY: 0,
                          toY: vals[1],
                          color: _lightColor,
                          width: 10,
                          borderRadius: BorderRadius.zero,
                        ),
                        BarChartRodData(
                          fromY: 0,
                          toY: vals[2],
                          color: _modHighColor,
                          width: 10,
                          borderRadius: BorderRadius.zero,
                        ),
                      ],
                      barsSpace: 4,
                      showingTooltipIndicators: [],
                    );
                  }).toList(),
                  barTouchData: BarTouchData(enabled: false),
                ),
                duration: const Duration(milliseconds: 150),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Color(0xFF5A5A58)),
        ),
      ],
    );
  }
}

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'chart/blood_oxygen_chart.dart';
import 'heart_rate_chart_helper.dart';
import 'chart/heart_rate_chart.dart';

class BaseDataPage extends StatefulWidget {
  const BaseDataPage({super.key});

  @override
  State<BaseDataPage> createState() => _BaseDataPageState();
}

class _BaseDataPageState extends State<BaseDataPage> {
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                // fit: BoxFit.contain,
                fit: BoxFit.cover,
              ),
            ),
          ),
          buildContent(context),
        ],
      ),
    );
  }

  buildContent(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
                  SizedBox(width: 16),
                  buildTabs(context),
                ],
              ),
              SizedBox(height: 15),
              buildPannelGrids(),
              SizedBox(height: 15),

              // buildHeartRateLineChartCard(),
              HeartRateGraph(),
              SizedBox(height: 15),
              BloodOxygenChart()
              // buildNightLineChartCard(),
            ],
          ),
        ),
      ),
    );
  }

  buildTabs(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      fixedWidth: 90,
      height: 40,
      initialValue: 0,
      children: {
        0: Text('日', style: TextStyle(color: Colors.white, fontSize: 16)),
        1: Text('月', style: TextStyle(color: Colors.white, fontSize: 16)),
        2: Text('年', style: TextStyle(color: Colors.white, fontSize: 16)),
      },
      innerPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/tab_bg.png'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            Colors.white.withAlpha(180),
            BlendMode.srcATop,
          ),
        ),
      ),
      thumbDecoration: BoxDecoration(
        color: Color(0x3B000000).withOpacity(0.23),
        borderRadius: BorderRadius.circular(100),
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      onValueChanged: (v) {
        print(v);
      },
    );
  }

  buildPannelGrids() {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: buildPannelGridItem(
                bgImage: 'assets/images/heart_rate_bg.png',
                title: '步数',
                unit: '步',
                data: '8567',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: buildPannelGridItem(
                bgImage: 'assets/images/drop_bg.png',
                title: '心率',
                unit: '次/分',
                data: '78',
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: buildPannelGridItem(
                bgImage: 'assets/images/tem_bg.png',
                title: '体温',
                unit: '℃',
                data: '36.5',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: buildPannelGridItem(
                bgImage: 'assets/images/breath_bg.png',
                title: '呼吸',
                unit: '次/分',
                data: '18',
              ),
            ),
          ],
        ),
      ],
    );
  }

  buildPannelGridItem({
    required String bgImage,
    required String title,
    String? unit,
    String? data,
  }) {
    return Container(
      height: 120,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.fill),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                data ?? '',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4),
              Text(
                unit ?? '',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          Text(title, style: TextStyle(fontSize: 13, color: Colors.white)),
        ],
      ),
    );
  }

  //MARK心率趋势图卡片
  buildHeartRateLineChartCard() {
    return Container(
      height: 222,
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
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
                    'assets/icons/heart_rate_icon.png',
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "24小时心率趋势",
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
                  SizedBox(width: 8),
                  Text(
                    "5 min average",
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
          SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final data = _generateSampleData();
                  final maxSpot = data.reduce((a, b) => a.y > b.y ? a : b);
                  final minSpot = data.reduce((a, b) => a.y < b.y ? a : b);

                  const leftReserved = 35.0;
                  const bottomReserved = 30.0;
                  const double minX = 0, maxX = 24, minY = 40, maxY = 160;

                  final chartWidth = constraints.maxWidth - leftReserved;
                  final chartHeight = constraints.maxHeight - bottomReserved;

                  final maxPixelX =
                      leftReserved +
                      (maxSpot.x - minX) / (maxX - minX) * chartWidth;
                  final maxPixelY =
                      (1 - (maxSpot.y - minY) / (maxY - minY)) * chartHeight;

                  final minPixelX =
                      leftReserved +
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
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  );
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
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
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        '${value.toInt().toString().padLeft(2, '0')}:00',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    );
                                  }
                                  return SizedBox.shrink();
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData:
                              HeartRateChartHelper.buildSegmentedLineBars(data),
                          lineTouchData: LineTouchData(enabled: false),
                        ),
                      ),
                      // 最高点圆点
                      Positioned(
                        left: maxPixelX - 5,
                        top: maxPixelY - 5,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // 最低点圆点
                      Positioned(
                        left: minPixelX - 5,
                        top: minPixelY - 5,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            border: BoxBorder.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            color: Color(0xFFFF8F41),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        left: maxPixelX - 39 / 2,
                        top: maxPixelY - 43,
                        child: buildHightIndicator(
                          maxSpot.x.toInt(),
                          maxSpot.y.toInt(),
                        ),
                      ),
                      Positioned(
                        left: minPixelX - 39 / 2,
                        top: minPixelY - 43,
                        child: buildLowIndicator(
                          minSpot.x.toInt(),
                          minSpot.y.toInt(),
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

  List<FlSpot> _generateSampleData() {
    // 生成24小时的示例心率数据
    return [
      const FlSpot(0, 70),
      // const FlSpot(2, 65),
      const FlSpot(4, 60),
      // const FlSpot(6, 58),
      const FlSpot(8, 75),
      // const FlSpot(10, 85),
      const FlSpot(12, 90),
      // const FlSpot(14, 95),
      const FlSpot(16, 100),
      // const FlSpot(18, 128),
      const FlSpot(20, 128),
      // const FlSpot(22, 85),
      const FlSpot(24, 75),
    ];
  }

  Widget buildHightIndicator(int x, int y) {
    return Container(
      width: 39,
      height: 35,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/hight.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 4),
          Text(
            '$y',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          Text(
            '${x.toString().padLeft(2, '0')}:00',
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

  Widget buildLowIndicator(int x, int y) {
    return Container(
      width: 39,
      height: 35,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/low.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 4),
          Text(
            '$y',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          Text(
            '${x.toString().padLeft(2, '0')}:00',
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

  buildNightLineChartCard() {
    return Container(
      height: 222,
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
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
                  Image.asset('assets/icons/night.png', width: 16, height: 16),
                  SizedBox(width: 8),
                  Text(
                    "夜间血氧",
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
          SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: LineChart(
                LineChartData(
                  minY: 80,
                  maxY: 100,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    drawHorizontalLine: true,
                    verticalInterval: 6,
                    horizontalInterval: 10,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(color: Colors.transparent, strokeWidth: 1);
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
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
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
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                '${value.toInt().toString().padLeft(2, '0')}:00',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _generateOxygenData(),
                      isCurved: true,
                      color: Color(0xFF978EED),
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Color(0xFF978EED).withOpacity(0.4),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF978EED).withOpacity(0.4),
                            Color(0xFF978EED).withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(enabled: false),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _generateOxygenData() {
    return [
      FlSpot(0, 97),
      FlSpot(2, 92),
      FlSpot(4, 98),
      FlSpot(6, 89),
      FlSpot(8, 95),
      FlSpot(10, 91),
      FlSpot(12, 97),
      FlSpot(14, 88),
      FlSpot(16, 94),
      FlSpot(18, 90),
      FlSpot(20, 96),
      FlSpot(22, 93),
      FlSpot(24, 98),
    ];
  }
}

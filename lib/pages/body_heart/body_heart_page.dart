import 'package:flutter/material.dart';
import 'package:herplus/core/utils/nav_utils.dart';
import 'package:herplus/pages/temp_pages/base_data_page.dart';
import 'package:herplus/pages/temp_pages/period_page.dart';
import 'package:herplus/pages/temp_pages/power_detail_page.dart';
import 'package:herplus/pages/temp_pages/sleep_detail_page.dart';
import 'package:herplus/pages/temp_pages/stress_page.dart';

class BodyHeartPage extends StatelessWidget {
  const BodyHeartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: buildContent(),
    );
  }

  buildContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildHead(),
            buildHot(),
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Flex(
                mainAxisSize: MainAxisSize.min,
                direction: Axis.horizontal,
                children: [
                  Expanded(child: buildSleepCard()),
                  Expanded(child: buildTemperatureCard()),
                ],
              ),
            ),

            const CustomCalendar(),
          ],
        ),
      ),
    );
  }

  buildHead() {
    return Stack(
      children: [
        Center(
          child: Image.asset(
            width: 500,
            height: 300,
            "assets/images/big_bg2.png",
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Image.asset(
            "assets/images/big_bg.png",
            width: 300,
            height: 300,
          ),
        ),
        Positioned(right: 50, child: buildStressCard()),
        Positioned(left: 60, top: 100, child: buildHeartBeatCard()),
        Positioned(right: 70, top: 180, child: buildDateCard()),
      ],
    );
  }

  buildStressCard() {
    return Container(
      width: 110,
      height: 98,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bg1.png")),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/icons/stress_icon.png",
                width: 32,
                height: 32,
              ),
              SizedBox(width: 4),
            ],
          ),
          Text(
            "42 ｜平衡",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
          Text(
            "压力值",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  buildHeartBeatCard() {
    return
      GestureDetector(
        onTap: () {
          NavUtils.push(BaseDataPage());
        },
        child: Container(
          width: 110,
          height: 98,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg2.png")),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/icons/heart_icon.png", width: 32, height: 32),
                  SizedBox(width: 4),
                ],
              ),
              Text(
                "73 bpm|98%",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "心率/血氧",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
      ;
  }

  buildDateCard() {
    return
      GestureDetector(
        onTap: () {
          NavUtils.push(PeriodPage());
        },
        child: Container(
          width: 110,
          height: 98,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg3.png")),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/icons/temp_icon.png", width: 32, height: 32),
                  SizedBox(width: 4),
                ],
              ),
              Text(
                "118/76mmHg",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "经期/排卵日",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
      ;
  }

  buildHot() {
    return
      GestureDetector(
        onTap: () {
          NavUtils.push(PowerDetailPage());
        },
        child: Container(
          height: 120,
          padding: EdgeInsets.all(30),
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/xiaohao.png"),
              // fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "·今日消耗2,140kcal",
                style: TextStyle(color: Color(0xFFF5FBDD), fontSize: 18),
              ),
              Text("活力潮汐", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      )
      ;
  }

  buildSleepCard() {
    return
      GestureDetector(
        onTap: () {
          NavUtils.push(SleepDetailPage());
        },
        child: Container(
          height: 370,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/sleep_card.png"),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text("睡眠意识云", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("8h12m • 8分", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      )
      ;
  }

  buildTemperatureCard() {
    return
      GestureDetector(
        onTap: () {
          NavUtils.push(StressPage());
        },
        child: Container(
          height: 370,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/tempulature.png"),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text("情绪气象站", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("平静·能量低 >", style: TextStyle(color: Color(0xFFC3EDF6))),
            ],
          ),
        ),
      )
      ;
  }
}

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _currentMonth = DateTime.now();

  final List<String> _weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  int _firstWeekdayOfMonth(DateTime date) {
    // 1 (Mon) to 7 (Sun)
    // We want 0 (Sun) to 6 (Sat)
    int weekday = DateTime(date.year, date.month, 1).weekday;
    return weekday % 7;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildWeekDays(),
          const SizedBox(height: 10),
          _buildDaysGrid(),

          Divider(color: Colors.white.withValues(alpha: 0.1)),
          Text(
            "今日心情怎么样？",
            style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
          ),
          _buildFaceGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: _previousMonth,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),

                  color: Colors.white.withValues(alpha: 0.5),
                ),
                child: Image.asset(
                  "assets/icons/arrow_l.png",
                  width: 12,
                  height: 12,
                ),
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: _nextMonth,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),

                  color: Colors.white.withValues(alpha: 0.5),
                ),
                child: Image.asset(
                  "assets/icons/arrow_r.png",
                  width: 12,
                  height: 12,
                ),
              ),
            ),
          ],
        ),

        SizedBox(width: 15),
        Text(
          "${_currentMonth.year}年${_currentMonth.month}月",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Image.asset("assets/icons/history.png", width: 20, height: 20),
        Text("历史趋势", style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildWeekDays() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _weekDays
          .map(
            (day) => Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDaysGrid() {
    final int daysCount = _daysInMonth(_currentMonth);
    final int firstWeekday = _firstWeekdayOfMonth(_currentMonth);
    final int totalCells = ((daysCount + firstWeekday) / 7).ceil() * 7;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        final int dayNumber = index - firstWeekday + 1;
        if (dayNumber <= 0 || dayNumber > daysCount) {
          return const SizedBox.shrink();
        }

        final bool isToday =
            _currentMonth.year == DateTime.now().year &&
            _currentMonth.month == DateTime.now().month &&
            dayNumber == DateTime.now().day;

        return _buildDateCell(dayNumber, isToday);
      },
    );
  }

  Widget _buildDateCell(int day, bool isToday) {
    // 这里可以根据需要高度自定义日期单元格
    return Container(
      decoration: BoxDecoration(
        color: isToday
            ? Color(0xFF707070).withValues(alpha: 0.4)
            : Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$day",
              style: TextStyle(
                // color: isToday
                //     ? Colors.white
                //     : Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (day % 7 == 0) // 示例：在某些日期下显示一个小圆点
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFFC4D58A),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  _buildFaceGrid() {
    return Row(
      children: [
        _buildFaceCell("assets/images/face1.png"),
        _buildFaceCell("assets/images/face2.png"),

        _buildFaceCell("assets/images/face3.png"),
      ],
    );
  }

  _buildFaceCell(String imagePath) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HerPlusEventDetailsPage extends StatelessWidget {
  const HerPlusEventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F3EE),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 320,
              child: Image.asset(
                'assets/images/cycle_details/SoundBath.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            // ── Scrollable content ──
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Spacer to reveal the image behind
                    const SizedBox(height: 260),

                    // ── Main content container ──
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F3EE),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          20,
                          24,
                          20,
                          24 + bottomInset,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Fee ──
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                const Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text: 'Fee¥ 100',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent)),
                                  TextSpan(
                                    text: '/Free',
                                  )
                                ])),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Full Moon Sound Bath / 满月颂钵',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF222222),
                              ),
                            ),
                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Text(
                                  'Time',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF999999),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Dec 24, 19:00-20:30',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  'Location',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF999999),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Color(0xFF999999),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    'Shanghai . Jing\'an Temple',
                                    style: TextStyle(
                                      color: Color(0xFF999999),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.navigation_outlined,
                                    size: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            _buildSectionCard(
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '参与人数',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        height: 32,
                                        child: Stack(
                                          children: List.generate(5, (index) {
                                            return Positioned(
                                              left: index * 20.0,
                                              child: Container(
                                                width: 32,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2,
                                                  ),
                                                  color: [
                                                    const Color(0xFFE8A87C),
                                                    const Color(0xFF85CDCA),
                                                    const Color(0xFFD4A5A5),
                                                    const Color(0xFF9DB5B2),
                                                    const Color(0xFFC9B1FF),
                                                  ][index],
                                                ),
                                                child: ClipOval(
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 18,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const SizedBox(width: 4),
                                      const Text(
                                        '24',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ),
                            const SizedBox(height: 12),

                            _buildSectionCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '活动流程',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildTimelineItem(
                                    color: Colors.purpleAccent.withValues(alpha: 0.8),
                                    time: '19:00-19:15',
                                    label: '签到&暖场',
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTimelineItem(
                                    color: Colors.purpleAccent.withValues(alpha: 0.8),
                                    time: '19:15-20:00',
                                    label: '满月颂钵冥想',
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTimelineItem(
                                    color:  Colors.purpleAccent.withValues(alpha: 0.8),
                                    time: '20:00-20:30',
                                    label: '茶点&交流',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),

                            _buildSectionCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '讲师介绍',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      // Avatar
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xFFF0E6D3),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 26,
                                            color: Color(0xFFBBA88C),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'LINA',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF333333),
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            '声音疗愈师、瑜伽修行者',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF999999),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),

                            _buildSectionCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    '注意事项',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '请着宽松舒服、建议空腹参与、自带瑜伽垫/毛毯',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF666666),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),

                            _buildSectionCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    '着装要求',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '白色或淡色系',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF666666),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Extra space for the bottom button
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Top navigation bar ──
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(top: topInset),
                child: SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(24),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'HerPlus Event Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  12 + bottomInset,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F3EE),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // RSVP / 报名
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF5AAFB0),
                            Color(0xFF49808E),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF3A7C8C).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // 报名逻辑
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: const Center(
                            child: Text(
                              'RSVP / 报名',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 添加到日历
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: const Color(0xFF5AAFB0),
                          width: 1.2,
                        ),
                        color: Colors.white.withOpacity(0.6),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // 添加到日历逻辑
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: const Center(
                            child: Text(
                              '添加到日历',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF49808E),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 取消报名
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // 取消报名逻辑
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Text(
                            '取消报名',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF999999),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section card wrapper
  static Widget _buildSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
          width: 0.8,
        ),
      ),
      child: child,
    );
  }

  /// Timeline item for 活动流程
  static Widget _buildTimelineItem({
    required Color color,
    required String time,
    required String label,
  }) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          time,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black45,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

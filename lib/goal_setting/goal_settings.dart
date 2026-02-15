import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class GoalSettingsPage extends StatelessWidget {
  const GoalSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final contentWidth = screenWidth < 375 ? screenWidth : 375.0;

            return Stack(
              fit: StackFit.expand,
              children: [
                const DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/goal_settings/gs_bg_main.png',
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.34, 0.72, 1.0],
                      colors: [
                        Color(0x14FFFFFF),
                        Color(0x0FECE8D7),
                        Color(0x22E4DFC5),
                        Color(0x2ED7D2B4),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: screenWidth,
                    height: 430,
                    child: IgnorePointer(
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.68, 1.0],
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.transparent,
                          ],
                        ).createShader(bounds),
                        blendMode: BlendMode.dstIn,
                        child: Opacity(
                          opacity: 0.86,
                          child: ClipRect(
                            child: Transform.rotate(
                              angle: math.pi,
                              child: SizedBox.expand(
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    heightFactor: 0.41908744,
                                    child: Image.asset(
                                      'assets/images/goal_settings/gs_bg_top.png',
                                      width: 400,
                                      height: 957,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: contentWidth,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        16,
                        topInset + 6,
                        16,
                        16 + bottomInset,
                      ),
                      child: Column(
                        children: [
                          _GoalNavBar(
                            onBack: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(height: 16),
                          const _GoalTargetCard(
                            title: '步数目标',
                            value: 10000,
                            icon: Icons.directions_run,
                            iconColor: Color(0xFFFF4D7F),
                            iconBg: Color(0xFFFFE8EE),
                          ),
                          const SizedBox(height: 12),
                          const _GoalTargetCard(
                            title: '卡路里目标',
                            value: 2500,
                            unit: 'kcal',
                            icon: Icons.local_fire_department,
                            iconColor: Color(0xFF91D824),
                            iconBg: Color(0xFFEFFEDE),
                          ),
                          const SizedBox(height: 12),
                          const _GoalTargetCard(
                            title: '站立/活动',
                            value: 12,
                            unit: '小时',
                            icon: Icons.more_time_rounded,
                            iconColor: Color(0xFF3AA7FF),
                            iconBg: Color(0xFFE3F2FF),
                          ),
                          const Spacer(),
                          const _GoalSaveButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _GoalSaveButton extends StatelessWidget {
  const _GoalSaveButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.85),
          width: 2,
        ),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF1C1F1C), Color(0xFF5D6355)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x21918264),
            offset: Offset(0, 5),
            blurRadius: 3.7,
          ),
        ],
      ),
      child: const Text(
        '保存',
        style: TextStyle(
          fontSize: 16,
          height: 1.17,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _GoalAdjustButton extends StatelessWidget {
  const _GoalAdjustButton({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        symbol,
        style: const TextStyle(
          fontSize: 22,
          height: 1,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _GoalNavBar extends StatelessWidget {
  const _GoalNavBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: onBack,
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    'assets/images/goal_settings/gs_icon_back.png',
                  ),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
             '目标设置',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalTargetCard extends StatefulWidget {
  final String title;
  final int value;
  final String? unit;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const _GoalTargetCard(
      {super.key,
      required this.title,
      required this.value,
      this.unit,
      required this.icon,
      required this.iconColor,
      required this.iconBg});

  @override
  State<_GoalTargetCard> createState() => _GoalTargetCardState();
}

class _GoalTargetCardState extends State<_GoalTargetCard> {
  late int _number;

  @override
  void initState() {
    super.initState();
    _number = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 88),
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
      decoration: BoxDecoration(
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
        children: [
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: widget.iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icon, color: widget.iconColor, size: 11),
              ),
              const SizedBox(width: 8),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _number--;
                  });
                },
                child: _GoalAdjustButton(symbol: '-'),
              ),
              Expanded(
                child: Center(
                  child: widget.unit == null
                      ? Text(
                          _number.toString(),
                          style: const TextStyle(
                            fontSize: 40,
                            height: 0.95,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        )
                      : RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: _number.toString(),
                                style: const TextStyle(
                                  fontSize: 40,
                                  height: 0.95,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              TextSpan(
                                text: widget.unit,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.17,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFB8B8B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _number++;
                  });
                },
                child: _GoalAdjustButton(symbol: '+'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
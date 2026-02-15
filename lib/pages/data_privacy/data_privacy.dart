
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herplus/core/utils/nav_utils.dart';
import 'package:herplus/pages/merge/project_details.dart';


class DataPrivacyPage extends StatefulWidget {
  const DataPrivacyPage({super.key});

  @override
  State<DataPrivacyPage> createState() => _DataPrivacyPageState();
}

class _DataPrivacyPageState extends State<DataPrivacyPage> {
  bool firstToggle = true;
  bool secondToggle = true;
  bool thirdToggle = false;

  static const Color cardFill = Color(0x63FFFFFF);
  static const Color dividerColor = Color(0x0D000000);
  static const Color shadowColor = Color(0x21918264);

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
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
                        'assets/images/data_privacy/dp_bg_main.png',
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
                          child: _buildTopTextureOverlay(),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: contentWidth,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        16,
                        topInset + 6,
                        16,
                        24 + bottomInset,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildNavBar(context),
                          const SizedBox(height: 16),
                          _buildToggleCard(),
                          const SizedBox(height: 16),
                          _buildFileCards(),
                          const SizedBox(height: 16),
                          _buildActionsCard(),
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

  Widget _buildTopTextureOverlay() {
    return ClipRect(
      child: Transform.rotate(
        angle: math.pi,
        child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.fill,
            child: Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.41908744,
              child: Image.asset(
                'assets/images/data_privacy/dp_bg_top.png',
                width: 400,
                height: 957,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    'assets/images/data_privacy/dp_icon_back.png',
                  ),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              '数据与隐私',
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

  Widget _buildToggleCard() {
    return Container(
      decoration: _cardDecoration,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => NavUtils.push(ProjectDetailPage()),
            child: _ToggleRow(
              iconAsset: 'assets/images/data_privacy/dp_icon_brain.png',
              text: '更年期前期的 REM 睡眠图谱',
              value: firstToggle,
              showDivider: true,
              onTap: () => setState(() => firstToggle = !firstToggle),
            ),
          )
          ,
          _ToggleRow(
            iconAsset: 'assets/images/data_privacy/dp_icon_drop.png',
            text: '月经周期与心脏健康',
            value: secondToggle,
            showDivider: true,
            onTap: () => setState(() => secondToggle = !secondToggle),
          ),
          _ToggleRow(
            iconAsset: 'assets/images/data_privacy/dp_icon_sleep.png',
            text: '更年期前期的 REM 睡眠图谱更年期前期的 REM 睡眠图谱更年期前期的 REM 睡眠图谱更年期前期的 REM 睡眠图谱',
            value: thirdToggle,
            showDivider: false,
            onTap: () => setState(() => thirdToggle = !thirdToggle),
            isMultiLine: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFileCards() {
    return Row(
      children: const [
        Expanded(
          child: _FileCard(
            iconAsset: 'assets/images/data_privacy/dp_icon_pdf.png',
            title: 'PDF ',
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _FileCard(
            iconAsset: 'assets/images/data_privacy/dp_icon_csv.png',
            title: 'CSV ',
          ),
        ),
      ],
    );
  }

  Widget _buildActionsCard() {
    return Container(
      height: 118,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: _cardDecoration,
      child: Column(
        children: const [
          _ActionRow(
            iconAsset: 'assets/images/data_privacy/dp_icon_delete.png',
            title: '清理AI记录',
          ),
          Divider(height: 1, thickness: 1, color: dividerColor),
          _ActionRow(
            iconAsset: 'assets/images/data_privacy/dp_icon_setting.png',
            title: '体系设置',
          ),
        ],
      ),
    );
  }

  BoxDecoration get _cardDecoration {
    return BoxDecoration(
      color: cardFill,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: shadowColor, offset: Offset(0, 5), blurRadius: 3.7),
      ],
    );
  }
}


class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.iconAsset,
    required this.title,
    this.rightText,
  });

  final String iconAsset;
  final String title;
  final String? rightText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58.5,
      child: Row(
        children: [
          SizedBox(width: 24, height: 24, child: Image.asset(iconAsset)),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              height: 1.17,
              fontWeight: FontWeight.w400,
              color: Color(0xFF333333),
            ),
          ),
          const Spacer(),
          if (rightText != null)
            Text(
              rightText!,
              style: const TextStyle(
                fontSize: 16,
                height: 1.17,
                fontWeight: FontWeight.w400,
                color: Color(0xFF999999),
              ),
            ),
          if (rightText != null) const SizedBox(width: 6),
          SizedBox(
            width: 20,
            height: 20,
            child: Image.asset(
              'assets/images/data_privacy/dp_icon_chevron.png',
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.iconAsset,
    required this.text,
    required this.value,
    required this.showDivider,
    required this.onTap,
    this.isMultiLine = false,
  });

  final String iconAsset;
  final String text;
  final bool value;
  final bool showDivider;
  final VoidCallback onTap;
  final bool isMultiLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMultiLine ? 70 : 64,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(
          bottom: BorderSide(color: Color(0x0D000000), width: 1),
        )
            : null,
      ),
      child: Row(
        children: [
          SizedBox(width: 40, height: 40, child: Image.asset(iconAsset)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              maxLines: isMultiLine ? 2 : 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
            ),
          ),
          const SizedBox(width: 16),
          _FigmaToggle(value: value, onTap: onTap),
        ],
      ),
    );
  }
}


class _FigmaToggle extends StatelessWidget {
  const _FigmaToggle({required this.value, required this.onTap});

  final bool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 28,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: value ? const Color(0xFF34C759) : const Color(0x4D3C3C43),
        ),
        child: Stack(
          children: [
            if (value)
              const Positioned(
                left: 12,
                top: 9,
                child: SizedBox(
                  width: 1,
                  height: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
              ),
            Align(
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 39,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FileCard extends StatelessWidget {
  const _FileCard({required this.iconAsset, required this.title});

  final String iconAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      padding: const EdgeInsets.all(12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 32, height: 32, child: Image.asset(iconAsset)),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _FileActionButton(label: '分享', color: Color(0x33000000)),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _FileActionButton(label: '下载', color: Color(0x33004DFF)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FileActionButton extends StatelessWidget {
  const _FileActionButton({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}

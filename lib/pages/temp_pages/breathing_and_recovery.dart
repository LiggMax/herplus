import 'package:flutter/material.dart';

class BreathingAndRecovery extends StatelessWidget {
  const BreathingAndRecovery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildRow(
            icon: _buildHeartWithBoltIcon(),
            label: '睡眠平均心率',
            value: '72',
            unit: 'bpm',
          ),
          Divider(),
          _buildRow(
            icon: _buildHeartWithArrowIcon(),
            label: '心率下降率',
            value: '15',
            unit: 'bpm',
          ),
          Divider(),
          _buildRow(
            icon: _buildHeartWindIcon(),
            label: '呼吸干扰次数',
            value: '0',
            unit: '次',
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(
          Icons.self_improvement,
          size: 22,
          color: const Color(0xFF4FC3F7),
        ),
        const SizedBox(width: 8),
        const Text(
          '呼吸与恢复',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHeartWithBoltIcon() {
    return SizedBox(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFE5E4DC),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.favorite, size: 22, color: const Color(0xFFF06292)),
            Positioned(
              bottom: 6,
              child: Icon(Icons.bolt, size: 10, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeartWithArrowIcon() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFE5E4DC),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.favorite, size: 22, color: const Color(0xFFF06292)),
          Positioned(
            bottom: 5,
            child: Icon(Icons.arrow_downward, size: 10, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildHeartWindIcon() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFE5E4DC),
      ),
      child: Icon(
        Icons.air,
        size: 22,
        color: const Color(0xFF4FC3F7),
      ),
    );
  }

  Widget _buildRow({
    required Widget icon,
    required String label,
    required String value,
    required String unit,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

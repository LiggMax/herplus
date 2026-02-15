
import 'package:flutter/material.dart';
import 'package:herplus/pages/project_details/project_details.dart';
import 'package:herplus/pages/system_settings/system_settings.dart';
import 'package:herplus/pages/app_page/ui_page.dart';

import 'ai_chat.dart';
import '../algorithm_calibration/algorithm_calibration.dart';
import 'breathing_exercises.dart';
import 'data_container.dart';
import '../data_privacy/data_privacy.dart';
import '../device_manager/device_manager.dart';
import '../expert_details/expert_details.dart';
import 'firmware_upgrade.dart';
import '../../goal_setting/goal_settings.dart';
import '../../her_plus_event_details/her_plus_event_details.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});
  static const String dataPrivacy = '数据与隐私';
  static const String firmwareUpgrade = '固件升级';
  static const String aiChat = 'AI聊天';
  static const String goalSettings = '目标设置';
  static const String genderCognition = '性别认知';
  static const String trackingIntent = '追踪意愿';
  static const String cycleDetails = '周期详情';
  static const String bodyData = '身体数据';
  static const String privacyCommitment = '隐私承诺';
  static const String breathingExercisesPage = '呼吸练习';
  static const String systemSettingsPage = '系统设置';
  static const String deviceManager = '设备管家';
  static const String projectDetails = '项目详情';
  static const String expertDetails = '专家详情页';
  static const String algorithmCalibration = '算法校准';
  static const String herPlusEventDetails = 'HerPlus Event Details';

  static const List<String> pageTitles = [
    dataPrivacy,
    firmwareUpgrade,
    // aiChat,
    goalSettings,
    genderCognition,
    trackingIntent,
    cycleDetails,
    bodyData,
    privacyCommitment,
    // breathingExercisesPage,
    systemSettingsPage,
    deviceManager,
    projectDetails,
    expertDetails,
    algorithmCalibration,
    herPlusEventDetails
  ];

  Widget _buildPageByTitle(String title) {
    if (title == dataPrivacy) {
      return const DataPrivacyPage();
    }
    if (title ==firmwareUpgrade) {
      return const FirmwareUpgradePage();
    }
    if (title == aiChat) {
      return const AiChatPage();
    }
    if (title == goalSettings) {
      return const GoalSettingsPage();
    }
    if (title == genderCognition) {
      return const DataContainer(initialPage: 0);
    }
    if (title == trackingIntent) {
      return const DataContainer(initialPage: 1,);
    }
    if (title == cycleDetails) {
      return const DataContainer(initialPage: 2);
    }
    if (title == bodyData) {
      return const DataContainer(initialPage: 3);
    }
    if (title == privacyCommitment) {
      return const DataContainer(initialPage: 4);
    }
    if (title == breathingExercisesPage) {
      return const BreathingExercisesPage();
    }
    if (title == systemSettingsPage) {
      return const SystemSettingsPage();
    }
    if (title == deviceManager) {
      return const DeviceManagerPage();
    }
    if(title == projectDetails) {
      return const ProjectDetailPage();
    }
    if (title == expertDetails) {
      return const ExpertDetailsPage();
    }
    if(title == algorithmCalibration) {
      return const AlgorithmCalibrationPage();
    }
    if (title == herPlusEventDetails) {
      return const HerPlusEventDetailsPage();
    }
    return BlankPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.2,
          ),
          itemCount: pageTitles.length,
          itemBuilder: (context, index) {
            final title = pageTitles[index];
            return TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0x0A000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Color(0x14FFFFFF), width: 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => _buildPageByTitle(title),
                  ),
                );
              },
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  height: 1.3,
                  shadows: [
                    Shadow(
                      color: Color(0x66000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
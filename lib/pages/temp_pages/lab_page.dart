import 'package:flutter/material.dart';
import 'package:herplus/core/utils/nav_utils.dart';
import 'package:herplus/her_plus_event_details/her_plus_event_details.dart';

class LabPage extends StatelessWidget {
  const LabPage({super.key});
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios_new_outlined),

                  Text("科研实验室", style: TextStyle(fontSize: 16)),
                  SizedBox(width: 16),
                ],
              ),
            ),
            SizedBox(height: 15),
            Image.asset(
              'assets/images/fake6_1.png',
              height: 190,
              fit: BoxFit.fitWidth,

              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        NavUtils.push(HerPlusEventDetailsPage());
                      },
                      child: Image.asset(
                        'assets/images/fake6_2.png',
                        height: 110,
                        fit: BoxFit.fitWidth,

                        width: MediaQuery.of(context).size.width,
                      ),
                    )
                    ,
                    Image.asset(
                      'assets/images/fake6_3.png',
                      height: 110,
                      fit: BoxFit.fitWidth,

                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      'assets/images/fake6_4.png',
                      height: 110,
                      fit: BoxFit.fitWidth,

                      width: MediaQuery.of(context).size.width,
                    ),

                    // Add your content here
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // Add more widgets here if needed
          ],
        ),
      ),
    );
  }
}

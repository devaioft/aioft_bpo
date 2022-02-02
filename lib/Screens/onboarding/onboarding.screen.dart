import 'package:aioft_bpo/Screens/profile/profile_screen.dart';
import 'package:aioft_bpo/Widgets/button_widget.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: kCardColor,
          pages: [
            PageViewModel(
              title: 'Customer service is an Opportunity ',
              body: 'To exceed your customer’s expectations.',
              image: buildImage('assets/images/banner.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'People will forget what you said.',
              body:
                  'They will forget what you did. But they will never forget how you made them feel',
              image: buildImage('assets/images/3.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Ask your customer',
              body:
                  'To be part of the solution, and don’t view them as part of the problem.',
              image: buildImage('assets/images/4.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'People do not care ',
              body: 'how much you know until they know how much you care',
              image: buildImage('assets/images/5.png'),
              decoration: getPageDecoration(),
              footer: ButtonWidget(
                onClicked: () => goToHome(context),
                text: 'Get Started!',
              ),
            ),
          ],
          showDoneButton: false,
          showSkipButton: false,
          showNextButton: false,
          skip: const Text(
            'Skip',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          onSkip: () => goToHome(context),
          dotsDecorator: getDotDecoration(),
          skipFlex: 0,
          nextFlex: 0,
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );

  Widget buildImage(String path) => Center(
          child: Image.asset(
        path,
      ));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: const Color(0xFFBDBDBD),
        activeColor: kBtnColor,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: const TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: kBtnColor),
        bodyTextStyle:
            TextStyle(fontSize: 20, color: kBtnColor.withOpacity(0.8)),
        descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
        // pageColor: Colors.white,
      );
}

class DoneWidget extends StatelessWidget {
  const DoneWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: kBtnColor,
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Get Started!',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: kCardColor,
            )),
      ),
    );
  }
}

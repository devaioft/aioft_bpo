import 'package:aioft_bpo/Screens/fleet_screen.dart';
import 'package:aioft_bpo/Screens/providers_screen.dart';
import 'package:aioft_bpo/Widgets/card_widget.dart';
import 'package:aioft_bpo/Widgets/status.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              " Hey!\n Welcome",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            SizedBox(
              width: 150,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Aioft.com',
                    textAlign: TextAlign.center,
                    textStyle: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: kBtnColor,
                      fontFamily: 'Nunito-Bold',
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                totalRepeatCount: 10,
                pause: const Duration(milliseconds: 200),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15.0),
        Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: kBtnColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const CircleAvatar(
                backgroundColor: kIconEnabledColor,
                child: Icon(Icons.call, color: kBtnColor)),
            title: const Text('Start Voice Call',
                style: TextStyle(color: kCardColor)),
            subtitle: const Text("if you already added Agent?",
                style: TextStyle(color: Colors.grey)),
            trailing: IconButton(
              onPressed: () => Navigator.restorablePushNamed(
                  context, ProviderScreen.routeName),
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: kCardColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CardWidget(
                cardTitle: 'Providers',
                imageSrc: 'assets/images/provider.png',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProviderScreen(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CardWidget(
                cardTitle: 'Fleet Car',
                imageSrc: 'assets/images/fleet.png',
                onTap: () => Navigator.restorablePushNamed(
                    context, FleetScreen.routeName),
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: CardWidget(
                cardTitle: 'Teachers',
                imageSrc: 'assets/images/tech.png',
                onTap: () => Navigator.restorablePushNamed(
                    context, ProviderScreen.routeName),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CardWidget(
                cardTitle: 'Employee',
                imageSrc: 'assets/images/emp.png',
                onTap: () => Navigator.restorablePushNamed(
                    context, FleetScreen.routeName),
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        // Row(
        //   children: [
        //     Expanded(
        //       child: CardWidget(
        //         cardTitle: 'Users',
        //         imageSrc: 'assets/images/tech.png',
        //         onTap: () => Navigator.restorablePushNamed(
        //             context, UsersScreen.routeName),
        //       ),
        //     ),
        //     const SizedBox(width: 12),
        //     // Expanded(
        //     //   child: CardWidget(
        //     //     cardTitle: 'Employee',
        //     //     imageSrc: 'assets/images/emp.png',
        //     //     onTap: () => Navigator.restorablePushNamed(
        //     //         context, FleetScreen.routeName),
        //     //   ),
        //     // )
        //   ],
        // ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const StatusCardWidget(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

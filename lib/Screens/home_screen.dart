import 'package:aioft_bpo/Widgets/fleet_card_widgets.dart';
import 'package:aioft_bpo/Widgets/provider_card_widget.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                " Hey!\n Welcome",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                width: 110,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Aioft.Com',
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
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
          const SizedBox(height: 30.0),
          Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: kBtnColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ListTile(
              leading: CircleAvatar(child: Icon(Icons.call, color: kCardColor)),
              title:
                  Text('Start Voice Call', style: TextStyle(color: kCardColor)),
              subtitle:
                  Text("10+ Members", style: TextStyle(color: Colors.grey)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: kCardColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                child: ProviderCardWidget(
                  cardTitle: 'Providers',
                  imageSrc: 'assets/images/provider.png',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: FleetCardWidget(
                  cardTitle: 'Fleet Car',
                  imageSrc: 'assets/images/fleet.png',
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
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
      ),
    );
  }
}

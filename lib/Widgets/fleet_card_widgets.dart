
import 'package:aioft_bpo/Screens/fleet_screen.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';

class FleetCardWidget extends StatelessWidget {
  const FleetCardWidget({
    Key? key,
    this.imageSrc,
    this.cardTitle,
  }) : super(key: key);

  final String? imageSrc;
  final String? cardTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FleetScreen())),
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                  height: 90,
                  child: Image.asset(
                    imageSrc!,
                    color: kBtnColor,
                  )),
              const SizedBox(height: 12),
              Text(
                cardTitle!,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kTextColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

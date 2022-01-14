import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    this.imageSrc,
    this.cardTitle,
    this.onTap,
  }) : super(key: key);

  final String? imageSrc;
  final String? cardTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                  height: 75,
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

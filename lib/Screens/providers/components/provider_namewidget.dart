
import 'package:aioft_bpo/Models/user_model.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';

class ProviderNameWidget extends StatelessWidget {
  const ProviderNameWidget({
    Key? key,
    required this.user,
  
  }) : super(key: key);

  final Provider user;
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${user.firstName} ${user.lastName}',
        style: kNameStyle,
      ),
    );
  }
}

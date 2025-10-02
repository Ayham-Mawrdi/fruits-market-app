import 'package:flutter/material.dart';

import '../../../../../../core/constant.dart';
import '../../../../../../core/utils/sized_config.dart';

class DecorationDetailsWdiget extends StatelessWidget {
  final String? name;
  final String? email;
  const DecorationDetailsWdiget({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! * 0.25,
      decoration: const BoxDecoration(
        color: kMainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/profile.webp', // Your placeholder image
              width: SizeConfig.screenWidth! * 0.25, // Responsive circle size
              height: SizeConfig.screenWidth! * 0.25,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: SizeConfig.screenWidth! * 0.25,
                height: SizeConfig.screenWidth! * 0.25,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16), // Space between image and name

          Text(
            name ?? 'John Doe',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.screenHeight! * 0.01),

          Text(
            email ?? 'john.doe@example.com',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 20), // Bottom padding
        ],
      ),
    );
  }
}

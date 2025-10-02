import 'package:flutter/material.dart';
import 'package:fruits_market/core/constant.dart';

import '../../../../../core/utils/sized_config.dart';
import 'card_info_label.dart';

class CardPreview extends StatelessWidget {
  final String cardHolder;
  final String cardNumber;
  final String expiryDate;

  const CardPreview({
    super.key,
    required this.cardHolder,
    required this.cardNumber,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardBackground = LinearGradient(
      colors: [kMainColor, Colors.deepPurple.shade400],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      height: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.shade100,
            blurRadius: 30,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Credit Card',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            cardNumber.isEmpty ? 'XXXX XXXX XXXX XXXX' : cardNumber,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight! * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardInfoLabel(
                label: 'Card Holder',
                value: cardHolder.isEmpty
                    ? 'Your Name'
                    : cardHolder.toUpperCase(),
              ),
              CardInfoLabel(
                label: 'Expires',
                value: expiryDate.isEmpty ? 'MM/YY' : expiryDate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

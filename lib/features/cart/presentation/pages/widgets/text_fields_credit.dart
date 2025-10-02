import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/utils/formatters.dart';
import 'text_field_card.dart';

class TextFieldsCredit extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController numberController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final VoidCallback onChanged;

  const TextFieldsCredit({
    super.key,
    required this.nameController,
    required this.numberController,
    required this.expiryController,
    required this.cvvController,
    required this.onChanged,
  });

  bool isValidExpiryDate(String value) {
    if (value.length != 5 || !value.contains('/')) return false;
    final parts = value.split('/');
    if (parts.length != 2) return false;

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) return false;
    if (month < 1 || month > 12) return false;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Cardholder Name
        TextFieldCard(
          controller: nameController,
          label: 'Cardholder Name',
          hint: 'John Doe',
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter cardholder name';
            }
            return null;
          },
          onChanged: (_) => onChanged(),
        ),
        const SizedBox(height: 16),

        /// Card Number
        TextFieldCard(
          controller: numberController,
          label: 'Card Number',
          hint: '1234 5678 9012 3456',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CardNumberInputFormatter(),
          ],
          maxLength: 19,
          validator: (value) {
            if (value == null || value.replaceAll(' ', '').length != 16) {
              return 'Enter a valid 16-digit card number';
            }
            return null;
          },
          onChanged: (_) => onChanged(),
        ),
        const SizedBox(height: 16),

        /// Expiry + CVV Row
        Row(
          children: [
            Expanded(
              child: TextFieldCard(
                controller: expiryController,
                label: 'Expiry Date',
                hint: 'MM/YY',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ExpiryDateInputFormatter(),
                ],
                maxLength: 5,
                validator: (value) {
                  if (value == null || !isValidExpiryDate(value)) {
                    return 'Invalid expiry date';
                  }
                  return null;
                },
                onChanged: (_) => onChanged(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFieldCard(
                controller: cvvController,
                label: 'CVV',
                hint: '123',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return 'Invalid CVV';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

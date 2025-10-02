import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/utils/sized_config.dart';
import '../../../../core/widgets/custom_bottons.dart';
import 'widgets/text_fields_credit.dart';
import 'widgets/card_preview.dart';
import 'package:fruits_market/core/widgets/custom_app_bar.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key, required double total});

  @override
  State<CreditCardPage> createState() => CreditCardPageState();
}

class CreditCardPageState extends State<CreditCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  bool isLoading = false;
  bool isSuccess = false;
  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  String get formattedCardNumber {
    final text = _numberController.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i != 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(text[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'payment',
          leadingIcon: const Icon(
            MaterialIcons.arrow_back,
            color: Colors.white,
            size: 22,
          ),
          onPressed: () => Get.toNamed('main'),
        ),
        body: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.deepPurple, 
            size: 50,
          ),
        ),
      );
    } else if (isSuccess) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'payment',
          leadingIcon: const Icon(
            MaterialIcons.arrow_back,
            color: Colors.white,
            size: 22,
          ),
          onPressed: () => Get.toNamed('main'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Payment Successful',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Your Order is Booked.', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Add Your Card',
          leadingIcon: const Icon(
            MaterialIcons.arrow_back,
            color: Colors.white,
            size: 22,
          ),
          onPressed: () => Get.toNamed('main'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardPreview(
                    cardHolder: _nameController.text,

                    cardNumber: formattedCardNumber,
                    expiryDate: _expiryController.text,
                  ),
                  const SizedBox(height: 32),

                  /// Extracted widget
                  TextFieldsCredit(
                    nameController: _nameController,
                    numberController: _numberController,
                    expiryController: _expiryController,
                    cvvController: _cvvController,
                    onChanged: () => setState(() {}),
                  ),

                  SizedBox(height: SizeConfig.screenHeight! * 0.27),
                  Center(
                    child: CustomGeneralButton(
                      width: SizeConfig.screenHeight! * 0.34,
                      text: 'Save Card',
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() {
                            isLoading = true;
                          });
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              isLoading = false;
                              isSuccess = true;
                            });
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

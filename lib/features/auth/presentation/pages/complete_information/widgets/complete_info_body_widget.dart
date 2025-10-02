import 'package:flutter/material.dart';

import '../../../../../../core/widgets/custom_bottons.dart';
import '../../../../../../core/widgets/space_widget.dart';
import 'complete_information_item.dart';

class CompleteInfoBodyWidget extends StatelessWidget {
   const CompleteInfoBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          VerticalSpace(10),
          CompleteInfoItem(
            text: 'Enter your name',
          ),
          VerticalSpace(2),
          CompleteInfoItem(
            text: 'Enter your phone number',
          ),
          VerticalSpace(2),
          CompleteInfoItem(
            maxLines: 5,
            text: 'Enter your address',
          ),
          VerticalSpace(5),
          CustomGeneralButton(
            text: 'Login',
          )
        ],
      ),
    );
  }
}
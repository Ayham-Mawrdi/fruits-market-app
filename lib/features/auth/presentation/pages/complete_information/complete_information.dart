import 'package:flutter/material.dart';

import 'widgets/complete_info_body_widget.dart';

class CompleteInformation extends StatelessWidget {
  const CompleteInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: CompleteInfoBodyWidget()),
    );
  }
}

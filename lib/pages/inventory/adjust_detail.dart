import 'package:flutter/material.dart';

import 'components/adjust_body.dart';

class AdjustDetail extends StatelessWidget {
  const AdjustDetail();

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: screen.size.width,
          padding: const EdgeInsets.all(20),
          child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [WidgetBody()]),
        )),
      ),
    );
  }
}

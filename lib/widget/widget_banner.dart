import 'package:flutter/material.dart';

class WidgetBanner extends StatelessWidget {
  final Widget gAdsBanner;

  const WidgetBanner({Key? key, required this.gAdsBanner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          alignment: Alignment.center,
          height: 70,
          color: Colors.black,
          child: gAdsBanner,
        ),
      ),
    );
  }
}

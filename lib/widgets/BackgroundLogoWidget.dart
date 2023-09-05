import 'package:flutter/material.dart';

class BackgroundLogoWidget extends StatelessWidget {
  final Widget child;

  BackgroundLogoWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/logo.png"), // Đường dẫn đến hình ảnh của bạn
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Opacity(
            opacity: 0.5,
            child: FlutterLogo(size: 250),
          ),
        ),
      ],
    );
  }
}

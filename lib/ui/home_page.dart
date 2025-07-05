import 'package:flutter/material.dart';
import 'package:solid_software_test/services/color_service.dart';

/// The main home page
class MyHomePage extends StatefulWidget {
  /// The main home page constructor
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final ColorService _colorService;

  @override
  void initState() {
    super.initState();
    _colorService = ColorService(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _colorService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _colorService.changeColorImmediately,
        onLongPressStart: (_) =>
            _colorService.startColorTransition(durationInSeconds: 5),
        onLongPressEnd: (_) => _colorService.stopColorTransition(),
        child: ValueListenableBuilder<Color>(
          valueListenable: _colorService.color,
          builder: (context, value, child) {
            return ColoredBox(
              color: value,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Hello there",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: _colorService.contrastColor),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

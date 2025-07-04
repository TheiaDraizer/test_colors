import 'dart:math';
import 'package:flutter/material.dart';

/// Manages random color generation with immediate and animated transition
///
/// Usage:
/// ValueListenableBuilder<Color>(
///   valueListenable: _colorService.color,
///   builder: (context, color, child) => Container(
///     color: color,
///     child: Text('Hello', style: TextStyle(color: colorService.contrastColor)
///     ),
///   ),
/// )
class ColorService {
  final Random _random = Random();

  /// The animation controller that is used to animate the color transition
  late AnimationController animationController;

  /// Current random color
  ValueNotifier<Color> color = ValueNotifier<Color>(Colors.white);

  /// The contrast color (black or white)
  Color contrastColor = Colors.black;

  /// The color tween used to animate the color transition
  ColorTween? _colorTween;

  /// The duration of the color transition in seconds
  late int _transitionDurationInSeconds;

  /// Initialize the color service
  ColorService({
    required TickerProvider vsync,
    required int transitionDurationInSeconds,
  }) {
    _transitionDurationInSeconds = transitionDurationInSeconds;
    animationController = AnimationController(
      vsync: vsync,
      duration: Duration(seconds: _transitionDurationInSeconds),
    );

    final Color initialColor = _generateRandomColor();
    color.value = initialColor;
    contrastColor = _getTextColor(initialColor);
    animationController.addListener(_updateColorFromAnimation);
  }

  Color _generateRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  /// Returns the contrast color (black or white)
  Color _getTextColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
  }

  /// Updates current color during animation
  void _updateColorFromAnimation() {
    if (_colorTween != null && animationController.isAnimating) {
      final Color currentColor =
          _colorTween!.evaluate(animationController) ?? color.value;
      color.value = currentColor;
      contrastColor = _getTextColor(currentColor);
    }
  }

  /// Instantly changes to random color
  void changeColorImmediately() {
    animationController.stop();
    animationController.reset();
    _colorTween = null;
    final Color newColor = _generateRandomColor();
    color.value = newColor;
    contrastColor = _getTextColor(newColor);
  }

  /// Starts animated transition to a random color
  void startColorTransition() {
    final Color targetColor = _generateRandomColor();
    _colorTween = ColorTween(begin: color.value, end: targetColor);
    animationController.reset();
    animationController.forward();
  }

  /// Stops the current color transition
  void stopColorTransition() {
    animationController.stop();
    _colorTween = null;
  }

  /// Disposes color service resources
  void dispose() {
    animationController.removeListener(_updateColorFromAnimation);
    animationController.dispose();
    color.dispose();
  }
}

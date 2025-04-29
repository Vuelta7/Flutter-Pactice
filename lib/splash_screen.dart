import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

const String onboardingRoute = '/onboarding';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static final double ballSize = 100.0;
  double? top, left;
  double opacity = 0.6;
  double scale = 1.0;
  bool showTitle = false;
  bool showTagline = false;
  bool transitionOut = false;

  double rotationAngle = 0.0;
  double? previousLeft;
  double finalScale = 1.2;

  late final AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    )..addListener(() {
      if (mounted) {
        setState(() {
          rotationAngle = _rotationAnimation.value * 2 * math.pi;
        });
      }
    });

    // Ensure MediaQuery & layout are ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _startAnimation();
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  Future<void> _bounceTo({
    required double x,
    required double y,
    double newOpacity = 1.0,
    double? forcedSpinDirection,
    bool isFinalBounce = false,
  }) async {
    final double spinDirection =
        forcedSpinDirection ??
        (previousLeft != null && x > previousLeft! ? 1.0 : -1.0);

    final screenHeight = MediaQuery.of(context).size.height;
    final normalizedHeight = (screenHeight - y) / screenHeight;
    final stretchFactor = 1.1 + (normalizedHeight * 0.3);
    final squishFactor = 0.9 - (normalizedHeight * 0.1);

    if (!mounted) return;
    setState(() {
      top = y;
      previousLeft = left;
      left = x;
      scale = stretchFactor;
      opacity = newOpacity;
    });

    _rotationController.reset();
    _rotationAnimation = Tween<double>(
      begin: rotationAngle / (2 * math.pi),
      end: (rotationAngle / (2 * math.pi)) + spinDirection,
    ).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    )..addListener(() {
      if (mounted) {
        setState(() {
          rotationAngle = _rotationAnimation.value * 2 * math.pi;
        });
      }
    });

    _rotationController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() {
      scale = squishFactor;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    setState(() {
      scale = isFinalBounce ? finalScale : 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> _startAnimation() async {
    final screenSize = MediaQuery.of(context).size;
    final bottomY = screenSize.height - ballSize - screenSize.height * 0.05;
    final midY = screenSize.height * 0.5;
    const leftX = 0.0;
    final rightX = screenSize.width - ballSize;
    final centerX = (screenSize.width - ballSize) / 2;
    final topY = screenSize.height * 0.1;

    if (!mounted) return;
    setState(() {
      top = bottomY;
      left = leftX;
      previousLeft = leftX;
      opacity = 0.6;
    });

    await Future.delayed(const Duration(milliseconds: 600));
    await _bounceTo(
      x: rightX,
      y: bottomY - screenSize.height * 0.1,
      newOpacity: 0.7,
      forcedSpinDirection: 1.0,
    );

    await _bounceTo(
      x: leftX,
      y: midY,
      newOpacity: 0.8,
      forcedSpinDirection: -1.0,
    );

    await _bounceTo(
      x: rightX,
      y: midY / 2,
      newOpacity: 0.9,
      forcedSpinDirection: 1.0,
    );

    await _bounceTo(
      x: centerX,
      y: topY,
      newOpacity: 1.0,
      forcedSpinDirection: -1.0,
      isFinalBounce: true,
    );

    if (!mounted) return;
    setState(() {
      showTitle = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() {
      showTagline = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      transitionOut = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) {
      Navigator.pushReplacementNamed(context, onboardingRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: transitionOut ? 0.0 : 1.0,
        child: Stack(
          children: [
            if (top != null && left != null)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad,
                top: top!,
                left: left!,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Transform.rotate(
                      angle: rotationAngle,
                      child: Container(
                        width: ballSize,
                        height: ballSize,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(
                          'assets/images/jogaliga_logo.png',
                          key: const Key('splash_logo'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (top != null)
              Positioned(
                top: top! + ballSize + 20,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: showTitle ? 1.0 : 0.0,
                      child: Text(
                        'JogaLiga',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: const Color.fromRGBO(44, 62, 80, 1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: showTagline ? 1.0 : 0.0,
                      child: Text(
                        'Conecte o Time, Curta o Jogo',
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

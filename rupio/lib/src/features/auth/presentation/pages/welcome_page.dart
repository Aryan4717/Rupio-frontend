import 'package:flutter/material.dart';

/// Welcome Page - Animated welcome screen after successful login
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _featuresController;
  late AnimationController _buttonController;
  late AnimationController _glowController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _featuresOpacity;
  late Animation<double> _buttonOpacity;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );

    // Text animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    // Features animation
    _featuresController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _featuresOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _featuresController, curve: Curves.easeOut),
    );

    // Button animation
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _buttonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );

    // Glow animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // Start animations sequentially
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _logoController.forward();
    
    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();
    
    await Future.delayed(const Duration(milliseconds: 400));
    _featuresController.forward();
    _glowController.repeat(reverse: true);
    
    await Future.delayed(const Duration(milliseconds: 400));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _featuresController.dispose();
    _buttonController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  double _safeOpacity(double value) => value.clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A0A2E),
              Color(0xFF0D0D0D),
              Color(0xFF0D0D0D),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      // Animated Logo
                      AnimatedBuilder(
                        animation: Listenable.merge([_logoController, _glowController]),
                        builder: (context, child) {
                          return Opacity(
                            opacity: _safeOpacity(_logoOpacity.value),
                            child: Transform.scale(
                              scale: _logoScale.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFE91E8C).withOpacity(
                                        _safeOpacity(0.3 + (_glowAnimation.value * 0.3)),
                                      ),
                                      blurRadius: 40 + (_glowAnimation.value * 20),
                                      spreadRadius: 5 + (_glowAnimation.value * 10),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFF6B9D),
                                        Color(0xFFE91E8C),
                                        Color(0xFFC850C0),
                                      ],
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'R',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 56,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      // Welcome Text
                      AnimatedBuilder(
                        animation: _textController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _safeOpacity(_textOpacity.value),
                            child: SlideTransition(
                              position: _textSlide,
                              child: Column(
                                children: [
                                  const Text(
                                    'Welcome to Rupio!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Your journey to financial freedom starts now. Manage, invest, and grow your wealth with smart tools.',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 48),
                      // Features
                      AnimatedBuilder(
                        animation: _featuresController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _safeOpacity(_featuresOpacity.value),
                            child: Column(
                              children: [
                                _buildFeatureItem(
                                  icon: Icons.bolt_rounded,
                                  title: 'Instant Payments',
                                  subtitle: 'Send & receive money in seconds',
                                  color: const Color(0xFF00D4AA),
                                  delay: 0,
                                ),
                                const SizedBox(height: 16),
                                _buildFeatureItem(
                                  icon: Icons.shield_rounded,
                                  title: 'Bank-Grade Security',
                                  subtitle: 'Your money is always protected',
                                  color: const Color(0xFF5C6BC0),
                                  delay: 1,
                                ),
                                const SizedBox(height: 16),
                                _buildFeatureItem(
                                  icon: Icons.card_giftcard_rounded,
                                  title: 'Rewards & Cashback',
                                  subtitle: 'Earn on every transaction',
                                  color: const Color(0xFFFFD700),
                                  delay: 2,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              // Continue Button
              AnimatedBuilder(
                animation: _buttonController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _safeOpacity(_buttonOpacity.value),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to dashboard/home
                            Navigator.pushReplacementNamed(context, '/dashboard');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE91E8C),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Let's Get Started",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (delay * 150)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: _safeOpacity(value),
          child: Transform.translate(
            offset: Offset(30 * (1 - value), 0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E).withOpacity(0.6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: color.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 26),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.check_circle_rounded,
                    color: color,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


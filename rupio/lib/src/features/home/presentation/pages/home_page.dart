import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

/// Home page - Animated Onboarding Landing Screens
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  // Helper to safely clamp opacity
  double _safeOpacity(double value) => value.clamp(0.0, 1.0);

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchHomeData();

    // Glow pulse animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    _glowController.repeat(reverse: true);

    // Auto-scroll every 5 seconds
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < 2) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    _glowController.dispose();
    super.dispose();
  }

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
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: [
                    _buildWelcomeScreen(),
                    _buildPaymentsScreen(),
                    _buildRewardsScreen(),
                  ],
                ),
              ),
              _buildPageIndicator(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentPage == index
                ? const Color(0xFFE91E8C)
                : Colors.white.withOpacity(0.3),
          ),
        );
      }),
    );
  }

  // Screen 1: Welcome / Rupio Logo
  Widget _buildWelcomeScreen() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        final glowValue = _safeOpacity(_glowAnimation.value);
        return Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              final safeValue = _safeOpacity(value);
              return Opacity(
                opacity: safeValue,
                child: Transform.scale(
                  scale: 0.5 + (safeValue * 0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Glowing logo
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE91E8C).withOpacity(_safeOpacity(0.3 + (glowValue * 0.3))),
                              blurRadius: 40 + (glowValue * 20),
                              spreadRadius: 5 + (glowValue * 10),
                            ),
                            BoxShadow(
                              color: const Color(0xFFFF6B9D).withOpacity(_safeOpacity(0.2 + (glowValue * 0.2))),
                              blurRadius: 60 + (glowValue * 30),
                              spreadRadius: 10 + (glowValue * 15),
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
                                letterSpacing: -2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.8),
                            const Color(0xFFFF6B9D),
                            Colors.white.withOpacity(0.8),
                            Colors.white,
                          ],
                          stops: [
                            0.0,
                            _safeOpacity(0.35 + (glowValue * 0.1)),
                            0.5,
                            _safeOpacity(0.65 - (glowValue * 0.1)),
                            1.0,
                          ],
                        ).createShader(bounds),
                        child: const Text(
                          'Rupio',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Your Financial Freedom',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Screen 2: Payments
  Widget _buildPaymentsScreen() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        final glowValue = _safeOpacity(_glowAnimation.value);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated payment icons
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  final safeValue = _safeOpacity(value);
                  return Opacity(
                    opacity: safeValue,
                    child: Transform.scale(
                      scale: safeValue,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF00D4AA).withOpacity(0.2),
                              const Color(0xFF00B894).withOpacity(0.1),
                            ],
                          ),
                          border: Border.all(
                            color: const Color(0xFF00D4AA).withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00D4AA).withOpacity(_safeOpacity(0.2 + (glowValue * 0.2))),
                              blurRadius: 30 + (glowValue * 15),
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.payment_rounded,
                          size: 64,
                          color: Color(0xFF00D4AA),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 48),
              // Title
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  final safeValue = _safeOpacity(value);
                  return Opacity(
                    opacity: safeValue,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - safeValue)),
                      child: const Text(
                        'Smart Payments',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Description
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  final safeValue = _safeOpacity(value);
                  return Opacity(
                    opacity: safeValue,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - safeValue)),
                      child: Text(
                        'Pay instantly with UPI, cards, or wallets. Scan QR codes, split bills with friends, and schedule recurring payments effortlessly.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              // Payment method icons row
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  final safeValue = _safeOpacity(value);
                  return Opacity(
                    opacity: safeValue,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 16,
                      children: [
                        _buildPaymentIcon(Icons.qr_code_scanner_rounded, 'QR Pay'),
                        _buildPaymentIcon(Icons.credit_card_rounded, 'Cards'),
                        _buildPaymentIcon(Icons.account_balance_rounded, 'Bank'),
                        _buildPaymentIcon(Icons.phone_android_rounded, 'UPI'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Icon(icon, color: const Color(0xFF00D4AA), size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Screen 3: Rewards
  Widget _buildRewardsScreen() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        final glowValue = _safeOpacity(_glowAnimation.value);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated reward icon
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  final safeValue = _safeOpacity(value);
                  return Opacity(
                    opacity: safeValue,
                    child: Transform.scale(
                      scale: safeValue,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer glow ring
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  const Color(0xFFFFD700).withOpacity(_safeOpacity(0.3 + (glowValue * 0.2))),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          // Main icon container
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFFFD700),
                                  Color(0xFFFFA500),
                                  Color(0xFFFF8C00),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFFD700).withOpacity(_safeOpacity(0.4 + (glowValue * 0.2))),
                                  blurRadius: 30 + (glowValue * 15),
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.card_giftcard_rounded,
                              size: 56,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 48),
              // Title
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  final safeValue = _safeOpacity(value);
                  return Opacity(
                    opacity: safeValue,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - safeValue)),
                      child: const Text(
                        'Earn Rewards',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Description
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  final safeValue = _safeOpacity(value);
                  return Opacity(
                    opacity: safeValue,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - safeValue)),
                      child: Text(
                        'Get cashback on every transaction. Unlock exclusive coupons, earn reward points, and enjoy special discounts from top brands.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              // Reward features
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  final safeValue = _safeOpacity(value);
                  return Opacity(
                    opacity: safeValue,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildRewardFeature(Icons.percent_rounded, 'Cashback', const Color(0xFF00D4AA)),
                        _buildRewardFeature(Icons.local_offer_rounded, 'Coupons', const Color(0xFFE91E8C)),
                        _buildRewardFeature(Icons.stars_rounded, 'Points', const Color(0xFFFFD700)),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRewardFeature(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

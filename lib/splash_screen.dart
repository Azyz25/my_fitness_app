// lib/features/splash/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onDone;
  const SplashScreen({super.key, required this.onDone});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fadeIn;
  late Animation<double> _progress;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400));

    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );
    _progress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.3, 0.9, curve: Curves.easeInOut)),
    );
    _glow = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.0, 0.5, curve: Curves.elasticOut)),
    );

    _ctrl.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 400), widget.onDone);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Glow Logo
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonGreen.withOpacity(0.3 * _glow.value),
                          blurRadius: 40 * _glow.value,
                          spreadRadius: 10 * _glow.value,
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomPaint(
                        size: const Size(70, 70),
                        painter: _LogoPainter(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'منصة تكنيك للياقة',
                    style: GoogleFonts.tajawal(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'TECHNE FITNESS PLATFORM',
                    style: GoogleFonts.tajawal(
                      fontSize: 10,
                      color: AppColors.neonGreen,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 64),
                  // Progress bar
                  Container(
                    width: 140,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FractionallySizedBox(
                        widthFactor: _progress.value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.neonGreen,
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.neonGreen.withOpacity(0.7),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'جاري التحميل...',
                    style: GoogleFonts.tajawal(
                      fontSize: 12,
                      color: AppColors.darkTextMuted,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final neonPaint = Paint()
      ..color = AppColors.neonGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final glowPaint = Paint()
      ..color = AppColors.neonGreen.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // T symbol with pulse line
    final path = Path()
      ..moveTo(size.width * 0.1, size.height * 0.55)
      ..lineTo(size.width * 0.28, size.height * 0.55)
      ..lineTo(size.width * 0.34, size.height * 0.35)
      ..lineTo(size.width * 0.40, size.height * 0.75)
      ..lineTo(size.width * 0.46, size.height * 0.55)
      ..lineTo(size.width * 0.9, size.height * 0.55);

    // T top bar
    final tBar = Path()
      ..moveTo(size.width * 0.15, size.height * 0.28)
      ..lineTo(size.width * 0.42, size.height * 0.28)
      ..moveTo(size.width * 0.28, size.height * 0.28)
      ..lineTo(size.width * 0.28, size.height * 0.55);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, neonPaint);
    canvas.drawPath(tBar, glowPaint);
    canvas.drawPath(tBar, neonPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

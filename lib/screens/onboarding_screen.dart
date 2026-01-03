// filepath: lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'BUKLAT',
      'subtitle': 'Your friendly reading buddy!',
    },
    {
      'title': 'Learn with Fun',
      'subtitle': 'Stories, sounds, and simple games to make reading joyful.',
    },
    {
      'title': 'Ready to Read?',
      'subtitle': 'Start your reading adventure today!',
    },
  ];

  void _next() {
    if (_page < _pages.length - 1) {
      _controller.animateToPage(
        _page + 1,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryBlue, secondaryBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) => setState(() => _page = index),
                  itemBuilder: (context, index) {
                    final item = _pages[index];
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Mascot Icon
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                )
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.book_rounded,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            item['subtitle']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Navigation Controls
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _controller.jumpToPage(_pages.length - 1);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Page Indicators
                    Row(
                      children: List.generate(_pages.length, (i) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _page == i ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _page == i
                                ? Colors.white
                                : Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryBlue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        _page == _pages.length - 1 ? 'Start' : 'Next',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


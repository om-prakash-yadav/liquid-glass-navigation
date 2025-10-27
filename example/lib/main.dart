import 'package:flutter/material.dart';
import 'package:liquid_glass_nav/liquid_glass_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid Glass Nav Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExampleSelector(),
    );
  }
}

class ExampleSelector extends StatelessWidget {
  const ExampleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liquid Glass Nav Examples'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade50,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildExampleCard(
              context,
              'Default Style',
              'Classic glassmorphism with default settings',
              Icons.auto_awesome,
              Colors.purple,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DefaultExample()),
              ),
            ),
            _buildExampleCard(
              context,
              'With Badges',
              'Navigation items with notification badges',
              Icons.notifications_active,
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BadgeExample()),
              ),
            ),
            _buildExampleCard(
              context,
              'Different Animations',
              'Explore various icon transition animations',
              Icons.animation,
              Colors.teal,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AnimationExample()),
              ),
            ),
            _buildExampleCard(
              context,
              'Gradient Background',
              'Beautiful gradient glassmorphism effect',
              Icons.gradient,
              Colors.pink,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GradientExample()),
              ),
            ),
            _buildExampleCard(
              context,
              'Minimal Style',
              'Clean and minimal design without labels',
              Icons.minimize,
              Colors.indigo,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MinimalExample()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Default Example
class DefaultExample extends StatefulWidget {
  const DefaultExample({super.key});

  @override
  State<DefaultExample> createState() => _DefaultExampleState();
}

class _DefaultExampleState extends State<DefaultExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ExplorePage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default Style'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          LiquidGlassBottomNav(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              LiquidGlassNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
              ),
              LiquidGlassNavItem(
                icon: Icons.explore_rounded,
                label: 'Explore',
              ),
              LiquidGlassNavItem(
                icon: Icons.favorite_rounded,
                label: 'Favorites',
              ),
              LiquidGlassNavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Badge Example
class BadgeExample extends StatefulWidget {
  const BadgeExample({super.key});

  @override
  State<BadgeExample> createState() => _BadgeExampleState();
}

class _BadgeExampleState extends State<BadgeExample> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('With Badges'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange.shade100,
                  Colors.pink.shade100,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_active,
                    size: 80,
                    color: Colors.orange.shade400,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Badge Example',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Notice the notification badges!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          LiquidGlassBottomNav(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              LiquidGlassNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
              ),
              LiquidGlassNavItem(
                icon: Icons.chat_bubble_rounded,
                label: 'Messages',
                showBadge: true,
                badgeText: '3',
              ),
              LiquidGlassNavItem(
                icon: Icons.notifications_rounded,
                label: 'Alerts',
                showBadge: true,
                badgeText: '12',
                badgeColor: Colors.orange,
              ),
              LiquidGlassNavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                showBadge: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Animation Example
class AnimationExample extends StatefulWidget {
  const AnimationExample({super.key});

  @override
  State<AnimationExample> createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample> {
  int _currentIndex = 0;
  NavAnimationType _animationType = NavAnimationType.scale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Styles'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.teal.shade100,
                  Colors.cyan.shade100,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Animation Type:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    children: [
                      _buildAnimationChip('Scale', NavAnimationType.scale),
                      _buildAnimationChip('Slide Up', NavAnimationType.slideUp),
                      _buildAnimationChip(
                          'Rotate', NavAnimationType.rotateScale),
                      _buildAnimationChip('Fade', NavAnimationType.fade),
                    ],
                  ),
                ],
              ),
            ),
          ),
          LiquidGlassBottomNav(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            animationType: _animationType,
            items: const [
              LiquidGlassNavItem(
                icon: Icons.home_rounded,
                activeIcon: Icons.home,
                label: 'Home',
              ),
              LiquidGlassNavItem(
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore,
                label: 'Explore',
              ),
              LiquidGlassNavItem(
                icon: Icons.favorite_border,
                activeIcon: Icons.favorite,
                label: 'Favorites',
              ),
              LiquidGlassNavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationChip(String label, NavAnimationType type) {
    final isSelected = _animationType == type;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _animationType = type;
        });
      },
      backgroundColor: Colors.white,
      selectedColor: Colors.teal.shade200,
    );
  }
}

// Gradient Example
class GradientExample extends StatefulWidget {
  const GradientExample({super.key});

  @override
  State<GradientExample> createState() => _GradientExampleState();
}

class _GradientExampleState extends State<GradientExample> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradient Background'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.pink.shade200,
                  Colors.purple.shade300,
                  Colors.blue.shade300,
                ],
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.gradient, size: 80, color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    'Gradient Glass Effect',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          LiquidGlassBottomNav(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            useGradient: true,
            gradientColors: [
              const Color(0x40FF6B9D),
              const Color(0x40C06BFF),
            ],
            activeColor: Colors.white,
            inactiveColor: const Color(0xCCFFFFFF),
            items: const [
              LiquidGlassNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
              ),
              LiquidGlassNavItem(
                icon: Icons.explore_rounded,
                label: 'Explore',
              ),
              LiquidGlassNavItem(
                icon: Icons.favorite_rounded,
                label: 'Favorites',
              ),
              LiquidGlassNavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Minimal Example
class MinimalExample extends StatefulWidget {
  const MinimalExample({super.key});

  @override
  State<MinimalExample> createState() => _MinimalExampleState();
}

class _MinimalExampleState extends State<MinimalExample> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minimal Style'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.indigo.shade100,
                  Colors.white,
                ],
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.minimize, size: 80, color: Colors.indigo),
                  SizedBox(height: 20),
                  Text(
                    'Clean & Minimal',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'No labels, just icons',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          LiquidGlassBottomNav(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            showLabels: false,
            height: 70,
            iconSize: 32,
            activeColor: Colors.indigo,
            inactiveColor: Colors.indigo.shade200,
            items: const [
              LiquidGlassNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
              ),
              LiquidGlassNavItem(
                icon: Icons.search_rounded,
                label: 'Search',
              ),
              LiquidGlassNavItem(
                icon: Icons.add_circle_rounded,
                label: 'Add',
              ),
              LiquidGlassNavItem(
                icon: Icons.favorite_rounded,
                label: 'Favorites',
              ),
              LiquidGlassNavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Example Pages (keeping the original ones)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade100,
            Colors.blue.shade100,
            Colors.pink.shade100,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home_rounded,
              size: 100,
              color: Colors.purple.shade700,
            ),
            const SizedBox(height: 20),
            Text(
              'Home',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange.shade100,
            Colors.red.shade100,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.explore_rounded,
              size: 100,
              color: Colors.orange.shade700,
            ),
            const SizedBox(height: 20),
            Text(
              'Explore',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.pink.shade100,
            Colors.red.shade100,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_rounded,
              size: 100,
              color: Colors.red.shade700,
            ),
            const SizedBox(height: 20),
            Text(
              'Favorites',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigo.shade100,
            Colors.purple.shade100,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.shade400,
                    Colors.indigo.shade400,
                  ],
                ),
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 70,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/catalog_screen_widget.dart';
import 'pages/add_item_widget.dart';
import 'pages/splash_screen_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL_HERE',
    anonKey: 'YOUR_SUPABASE_ANON_KEY_HERE',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wool Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4B394F),
          primary: const Color(0xFF4B394F),
          secondary: const Color(0xFF39D3C0),
          tertiary: const Color(0xFFEE8B60),
          surface: const Color(0xFFF1F4F8),
          onSurface: const Color(0xFF14181B), // primaryText
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F4F8), // primaryBackground
        textTheme: TextTheme(
          displayLarge: GoogleFonts.interTight(
              fontSize: 64,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF14181B)),
          displayMedium: GoogleFonts.interTight(
              fontSize: 44,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF14181B)),
          displaySmall: GoogleFonts.interTight(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF14181B)),
          headlineLarge: GoogleFonts.interTight(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF14181B)),
          headlineMedium: GoogleFonts.interTight(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF14181B)),
          headlineSmall: GoogleFonts.interTight(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF14181B)),
          titleLarge: GoogleFonts.interTight(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF14181B)),
          titleMedium: GoogleFonts.interTight(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF14181B)),
          titleSmall: GoogleFonts.interTight(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF14181B)),
          bodyLarge: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF14181B)),
          bodyMedium: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF14181B)),
          bodySmall: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF14181B)),
          labelLarge: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57636C)), // secondaryText
          labelMedium: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57636C)),
          labelSmall: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57636C)),
        ),
      ),
      home: const SplashScreenWidget(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CatalogScreenWidget(),
    const AddItemScreenWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Catalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Item',
          ),
        ],
      ),
    );
  }
}

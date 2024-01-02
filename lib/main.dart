import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:youvie/components/carousel.dart";
import 'package:youvie/models/movie.dart';
import 'components/menu_drawer.dart';

void main() => runApp(const MyApp(),);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'youVie Demo';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ),

        textTheme: TextTheme(
          titleLarge: GoogleFonts.anton(
            fontSize: 36,
          ),

          labelLarge: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),

          labelMedium: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),

          bodyMedium: GoogleFonts.openSans(
            fontSize: 15,
          ),

        ),
      ),
      home: const RecommendationsPage(title: appTitle),
    );
  }
}

class RecommendationsPage extends StatefulWidget {
  const RecommendationsPage({super.key, required this.title});

  final String title;

  @override
  State<RecommendationsPage> createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  var selectedIndex = 0;
  late Future<List<Movie>> movies;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30, 
    fontWeight: FontWeight.bold,
  );
  static final List<Widget> _widgetOptions = <Widget>[
    const Carousel(),
    Text(
      'Watchlist Page',
      style: optionStyle,
    ),
    Text(
      'Watched Page',
      style: optionStyle,
    ),
    Text(
      'Ignored Page',
      style: optionStyle,
    ),
  ];

  void _onDrawerTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {{
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          style: Theme.of(context).textTheme.titleLarge,
          widget.title,
        ),
      ),
      body: Center(
        child: _widgetOptions[selectedIndex],
      ),
      drawer: MenuDrawer(selectedIndex: selectedIndex, updateDrawer: _onDrawerTapped,),
    );}
  }
}
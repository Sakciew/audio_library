import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'audio_provider.dart';
import 'uzbek_books_page.dart';
import 'world_books_page.dart';
import 'science_books_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AudioProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final Color lightBrown = Color(0xFFA0522D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb7d3b0),
      appBar: AppBar(
        title: Text('Audio kitoblar', style: TextStyle(color: Colors.white)),
        backgroundColor: lightBrown,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset('assets/images/main.png', height: 480, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 40),
                  _categoryButton(context, "O'zbek adabiyoti", UzbekBooksPage()),
                  _categoryButton(context, "Jahon adabiyoti", WorldBooksPage()),
                  _categoryButton(context, "Ilmiy adabiyotlar", ScienceBooksPage()),
                ],
              ),
            ),
          ),
          // MINI PLAYER PANEL
          _miniPlayer(context),
        ],
      ),
    );
  }

  Widget _categoryButton(BuildContext context, String text, Widget page) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFA0522D),
          minimumSize: Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
        child: Text(text, style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  Widget _miniPlayer(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audio, child) {
        if (audio.currentTitle == null) return SizedBox.shrink();
        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFA0522D),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Icon(Icons.music_note, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    audio.currentTitle!,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(audio.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                  onPressed: () => audio.playPause(audio.currentTitle!, ""),
                ),
                IconButton(
                  icon: Icon(Icons.stop, color: Colors.white),
                  onPressed: () => audio.stop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}